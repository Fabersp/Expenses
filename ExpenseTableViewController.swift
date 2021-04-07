
import UIKit
import WebKit

// Image extension
extension UIImage {
    
    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}

class ExpenseTableViewController: UITableViewController, ReloadDataProtocol {
    
    static let EXPENSES_OBSERVER = "EXPENSES_OBSERVER"
    static var IS_SYNCHING = false
    
    var expenses = [ExpenseDataModel]()
    var expenseOrganizer = [DateKey: [ExpenseDataModel]]()
    var organizerSortedKeys = [DateKey]()
    var sectionIsOpenMapper = [DateKey: Bool]()
    var expensesInSync = [ExpenseDataModel]()
    
    var tableViewTutorial: TutorialView!
    
    let viewBackground = UIView()
    
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var uploadButton: UIBarButtonItem!
    @IBOutlet weak var concludeButton: UIBarButtonItem!
    
    
    func showMenu() {
        let despesasController = self.storyboard!.instantiateViewController(withIdentifier: DespesasViewController.storyboardId);
        despesasController.modalPresentationStyle = .fullScreen;
        
        self.present(despesasController, animated: true, completion: nil);
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.visibilityConcludeButton(status: false);
        
        if UserSingleton.isAuthenticated() {
            
            RESTCallHelper.permissoesDispositivo(callback: {result in
                if result?.permiteExpense == false{
                    self.visibilityUploadButton(status: false)
                }
            })
        }

        
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        if let cor = UserSingleton.cor {
            let color = UIColor.colorWithHexString(cor)
            navigationController?.navigationBar.barTintColor = color
        }
        
        tableViewTutorial = TutorialView.instanceFromNib()
        tableViewTutorial.frame = tableView.frame
        
        translateView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: ExpenseTableViewController.EXPENSES_OBSERVER), object: nil)
        
        if expenses.count == 0 {
            tableView.backgroundView = tableViewTutorial
        }
        
        if self.revealViewController() != nil {
            
            if UserSingleton.isLogged {
                menuButton.image = UIImage(named: "ArrowLeftIcon")
                menuButton.target = self
                menuButton.action = #selector(ExpenseTableViewController.goToMainMenu)
            }
            else {
                menuButton.target = self.revealViewController()
                menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            }
        }
        
        self.navigationController!.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg_menu_2.jpg")!)
        self.tableView.backgroundColor = UIColor.clear
        
        self.reloadData()
    
    }
    
    @objc func goToMainMenu() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnalyticsHelper.trackScreen("ExpensesList")
        
    }
    
    func translateView() {
        self.title = NSLocalizedString("EXPENSES", comment:"User Expenses")
    }
    
    func visibilityConcludeButton(status: Bool) {
        self.concludeButton.isEnabled = status;
        self.concludeButton.title = status ? NSLocalizedString("CONCLUDE", comment:"Complete") : "";
    }
    
    func visibilityUploadButton(status: Bool) {
        self.uploadButton.isEnabled = status;
        self.uploadButton.image = status ? UIImage(named: "UploadWhite24dp") : nil;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadOrganizer() {
        
        expenseOrganizer.removeAll()
        for expense in expenses {
            let date = DBManager.getNSDateFromMillis(expense.date!)
            let components = (Calendar.current as NSCalendar).components([.day, .month, .year], from: date)
            let key = DateKey(month: components.month!, year: components.year!, day: components.day!)
            if expenseOrganizer.keys.contains(key) {
                var expensesArray = expenseOrganizer[key]!
                expensesArray += [expense]
                expenseOrganizer[key] = expensesArray
            } else {
                expenseOrganizer[key] = [expense]
            }
            
            if !sectionIsOpenMapper.keys.contains(key) { sectionIsOpenMapper[key] = true }
        }
        
        organizerSortedKeys = Array(expenseOrganizer.keys)
        organizerSortedKeys.sort(by: { $1.hashValue < $0.hashValue })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return expenseOrganizer.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let organizerSection = organizerSortedKeys[section]
        if sectionIsOpenMapper[organizerSection]! {
            return expenseOrganizer[organizerSection]!.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let expenseKeyInSection = organizerSortedKeys[indexPath.section]
        let expense = expenseOrganizer[expenseKeyInSection]![indexPath.row]
        
        let cell = ExpenseControllerHelper.populateTableViewCell(tableView, withExpense: expense)
        
        cell.activityIndicator.isHidden = !expensesInSync.contains(where: {$0.uuid == expense.uuid})
        if !cell.activityIndicator.isHidden { cell.activityIndicator.startAnimating() }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let expenseSectionKey = self.organizerSortedKeys[indexPath.section]
        let expense = self.expenseOrganizer[expenseSectionKey]![indexPath.row]
        
        var actions = [UITableViewRowAction]()
        
        if expense.isCorporate() && (expense.sync ?? 0) == 0 {
        
            let syncAction = UITableViewRowAction(style: .normal, title: "Sync") { (rowAction:UITableViewRowAction, indexPath:IndexPath) -> Void in
                
                guard !self.expensesInSync.contains(where: {$0.uuid == expense.uuid}) else { return }
                
                self.syncExpense(expense, callback: nil)
                
            }
            syncAction.backgroundColor = UIColor.blue
            
            actions.append(syncAction)
        }
        
        let deleteText = NSLocalizedString("DELETE", comment: "Delete")
        let deleteAction = UITableViewRowAction(style: .normal, title: deleteText) { (rowAction:UITableViewRowAction, indexPath:IndexPath) -> Void in
            
            guard !self.expensesInSync.contains(where: {$0.uuid == expense.uuid}) else { return }
            
            AnalyticsHelper.sendTrackingData("Click", action: "DeleteExpense")
            
            self.deleteExpense(expense)
            
        }
        
        deleteAction.backgroundColor = UIColor.red
        
        actions.append(deleteAction)
        
        return actions
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        AnalyticsHelper.sendTrackingData("Click", action: "ViewExpense")
        
        let expenseSectionKey = organizerSortedKeys[indexPath.section]
        let expense = expenseOrganizer[expenseSectionKey]![indexPath.row]
        
        guard !expensesInSync.contains(where: {$0.uuid == expense.uuid}) else { return }
        
        if let trackingId = expense.routeUUID {
            
            if let tracking = DBManager.getTracking(uuid: trackingId) {
                
                let mapsViewController: MapsViewController! = self.storyboard!.instantiateViewController(withIdentifier: MapsViewController.storyboardId) as! MapsViewController
                let navControl = UINavigationController(rootViewController: mapsViewController)
                navControl.modalPresentationStyle = .fullScreen
                navControl.navigationBar.barTintColor = UIHelper.PURPLE_COLOR
                navControl.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.white])
                mapsViewController.expense = expense
                mapsViewController.trackingData = tracking
                self.present(navControl, animated: true, completion: nil)
            }
            
        }
        else {
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            
            let viewExpenseController: ViewExpenseController! = storyboard.instantiateViewController(withIdentifier: ViewExpenseController.storyboardId) as! ViewExpenseController
            let navControl = UINavigationController(rootViewController: viewExpenseController)
            navControl.modalPresentationStyle = .fullScreen
            navControl.navigationBar.barTintColor = UIHelper.PURPLE_COLOR
            navControl.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.white])
            viewExpenseController.expense = expense
            self.present(navControl, animated: true, completion: nil)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = ExpenseTableViewHeader.instanceFromNib()
        headerCell.dateTitle.text = organizerSortedKeys[section].getFormattedDate()
        headerCell.section = section
        headerCell.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExpenseTableViewController.headerTap(_:)))
        tapGestureRecognizer.cancelsTouchesInView = true
        headerCell.addGestureRecognizer(tapGestureRecognizer)
        
        let key = organizerSortedKeys[section]
        let isOpen = !sectionIsOpenMapper[key]!
        
        headerCell.toggleArrowIcon(isOpen)
        
        return headerCell
    }
    
    @objc func headerTap(_ gestureRecognizer: UIGestureRecognizer)
    {
        if let view = gestureRecognizer.view as? ExpenseTableViewHeader {
            let key = organizerSortedKeys[view.section!]
            let isOpen = !sectionIsOpenMapper[key]!
            sectionIsOpenMapper[key] = isOpen
            reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // MARK: - Delete Expense
    
    func deleteExpense(_ expense: ExpenseDataModel) {
        
        if let picID = expense.receiptPicUUID
        {
            let imgPath = FilesHelper.fileInDocumentsDirectory(picID)
            
            guard FilesHelper.deleteFileFromDevice(imgPath) else { return  }
            guard DBManager.deleteReceiptPicture(picID) else { return  }
        }
        
        if let trackingId = expense.routeUUID {
            guard DBManager.deleteTracking(trackingId) else { return }
        }
        
        if DBManager.deleteExpense(expense.uuid!) {
            reloadData()
        }
        
    }
    
    // MARK: - Sync Expense
    
    func syncExpense(_ expense: ExpenseDataModel, callback: (()->())?){
        
        self.expensesInSync.append(expense)
        
        self.tableView.reloadData()
        
        let descricao = expense.description ?? ""
        
        let dataDespesa = DBManager.getNSDateFromMillis(expense.date!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedData = dateFormatter.string(from: dataDespesa)
        
        let valor = expense.price!
        let reembolsado = expense.isRefundable() ? "true" : "false"
        let moeda = expense.currency!
        let comprovado = expense.receiptPicUUID == nil ? "false" : "true"
        
        var params: [String:Any] = ["Descricao":descricao, "DataDespesa":formattedData, "Valor":valor, "Quantidade":"1", "Reembolsado":reembolsado, "Moeda":moeda, "Comprovado":comprovado]
        
        if let despId = expense.categoryUUID {
            params["DespesaId"] = despId as Any
        }
        
        if let picId = expense.receiptPicUUID {
            var image = FilesHelper.loadImageFromPath(picId)
            image = image?.updateImageOrientionUpSide()
            let imageData: NSData = image!.jpegData(compressionQuality: 0.3)! as NSData
            let base64String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            params["Imagem"] = base64String
            params["NomeImagem"] = picId
        }
        
        if let routeID = expense.routeUUID,
            let routeData = DBManager.getTracking(uuid: routeID) {
                params["percurso"] = routeData.getDictionaryData()
        }
        
        if let nroSolic = expense.nroSolic {
            params["nroSolic"] = nroSolic
        }
        
        insereDespesas(params as [String : AnyObject], expense: expense, callback: callback)
        
    }
    
    func insereDespesas(_ params: [String:AnyObject], expense: ExpenseDataModel, callback: (()->())?)  {
        
        let authParams = [RESTCallHelper.AuthenticationParams.login: UserSingleton.urlusuario!,
                          RESTCallHelper.AuthenticationParams.client_url: UserSingleton.urlcliente!,
                          RESTCallHelper.AuthenticationParams.password: UserSingleton.password!,
                          RESTCallHelper.AuthenticationParams.so: "iOS",
                          RESTCallHelper.AuthenticationParams.versaoMobile: "v\(Bundle.main.infoDictionary!["CFBundleShortVersionString"]!)"]
        
        RESTCallHelper.insereDespesa(authParams, params: params, agency_url: UserSingleton.urlagencia!, callback: {
            response in
            
            if let id = response.result.value as? String, response.response?.statusCode == 200 {
                DBManager.deleteExpense(expense.uuid!)
                expense.uuid = id
                expense.sync = 1
                if(DBManager.saveData(expense)) {
                    
                    if let callback = callback { callback() }
                }
                
                self.visibilityConcludeButton(status: true);
            }
            else {
                let alert = UIAlertController(title: nil, message: NSLocalizedString("NO_INTERNET_MSG", comment: "Error"), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            let index = self.expensesInSync.index(where: {$0.uuid == expense.uuid})!
            self.expensesInSync.remove(at: index)
            
            self.tableView.reloadData()
            self.checkForSyncExpenses()
            
        })
        
    }
    
    @IBAction func completeExpense(_ sender: Any) {
        let despesasViewController: DespesasViewController! = (self.storyboard!.instantiateViewController(withIdentifier: "despesasViewController") as! DespesasViewController)
        let navControl = UINavigationController(rootViewController: despesasViewController)
        navControl.modalPresentationStyle = .fullScreen
        navControl.navigationBar.barTintColor = UIHelper.PURPLE_COLOR
        navControl.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.white])
        self.present(navControl, animated: true, completion: nil)
    }
    
    @IBAction func syncAllExpenses(_ sender: UIBarButtonItem) {
        
        guard !ExpenseTableViewController.IS_SYNCHING else { return }
        
        ExpenseTableViewController.IS_SYNCHING = true
        AmplitudeService().log(event: "mobile/expense/btnSyncExpense")
        performSync()
        
    }
    
    func performSync() {
        if let expense = expenses.filter({$0.corporate == 1 && $0.sync != 1}).first {
            
            syncExpense(expense, callback: {
                self.performSync() })
        }
        else {
            ExpenseTableViewController.IS_SYNCHING = false
        }
        
        checkForSyncExpenses()
    }
    
    
    // MARK: - Check for SyncExpenses 
    
    func checkForSyncExpenses() {
        self.visibilityUploadButton(status: false)
        self.visibilityConcludeButton(status: false)

        if expenses.filter({$0.sync == 1}).first != nil {
            self.visibilityConcludeButton(status: true)
        }
        if expenses.filter({$0.corporate == 1 && $0.sync != 1}).first != nil {
            self.visibilityUploadButton(status: true)
        }
    }
    
    
    // MARK: ReloadDataProtocol
    
    @objc func reloadData() {
        
        if let data = DBManager.getAllExpenses() {
            
            expenses = data.filter({
                element in
                if element.isCorporate() {
                    return element.userId == UserSingleton.userId
                }
                else { return true }
            })
            
        }
        
        if expenses.count > 0 { tableView.backgroundView = nil }
        else { tableView.backgroundView = tableViewTutorial }
        loadOrganizer()
        self.tableView.reloadData()
        checkForSyncExpenses()
    }

}

// MARK: - HeaderClick Protocol

extension ExpenseTableViewController: HeaderClickProtocol {
    func headerClick(_ sectionIndex: Int) {
        let key = organizerSortedKeys[sectionIndex]
        sectionIsOpenMapper[key] = !sectionIsOpenMapper[key]!
        reloadData()
    }
}

// MARK: - Struct to Organize Data

func ==(lhs: DateKey, rhs: DateKey) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

struct DateKey : Hashable {
    
    var month: Int
    var year: Int
    var day: Int
    
    var hashValue : Int {
        get {
            return (year * 10000) + (month * 100) + day
        }
    }
    
    func getFormattedDate() -> String {
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        let date = calendar.date(from: components)
        return DBManager.formatDateForExpense(date!)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
