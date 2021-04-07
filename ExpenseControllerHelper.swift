
import Foundation

class ExpenseControllerHelper {
    
    fileprivate static func getCustomExpenseCell(from tableView: UITableView) -> CustomExpenseCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: CustomExpenseCell.IDENTIFIER) as? CustomExpenseCell
        if cell == nil
        {
            tableView.register(UINib(nibName: "CustomExpenseCell", bundle: nil), forCellReuseIdentifier: CustomExpenseCell.IDENTIFIER)
            cell = tableView.dequeueReusableCell(withIdentifier: CustomExpenseCell.IDENTIFIER) as? CustomExpenseCell
        }
        
        return cell!
        
    }
    
    static func populateTableViewCell(_ tableView: UITableView, withExpense expense: ExpenseDataModel) ->  CustomExpenseCell {
        
        let cell = getCustomExpenseCell(from: tableView)
        
        cell.activityIndicator.isHidden = true
        cell.priceLabel.text = Formatters.formatPrice(expense.price!)
        cell.currencyLabel.text = expense.currency
        cell.descriptionLabel.text = expense.description
        
        let categoryId = expense.categoryUUID ?? ""
        cell.categoryImg.image = UIHelper.getImageForCategory(categoryId)
        
        if expense.isCorporate() {
            let despesa = UserSingleton.tiposDespesa?.filter({ $0.despesaId == expense.categoryUUID }).first
            if let index = despesa?.nome?.index((despesa?.nome?.startIndex)!, offsetBy: 2) {
                cell.categoryLabel.text = despesa?.nome?.substring(to: index).uppercased()
            }
            
            cell.isCorporateImg.isHidden = false
            cell.isCorporateImg.image = UIHelper.getImage("Corporate18dp", withColor: UIHelper.GRAPHITE_COLOR)
        }
        else {
            let categoryText = UIHelper.getCategoryString(expense.categoryUUID ?? "")
            cell.categoryLabel.text = categoryText.substring(to: categoryText.index(categoryText.startIndex, offsetBy: 2)).uppercased()
            cell.isCorporateImg.isHidden = true
        }
        
        if let paymentId = expense.paymentMethodUUID {
            cell.paymentTypeImg.image = UIHelper.getImageForPaymentType(paymentId)
        } else {
            cell.paymentTypeImg.image = UIHelper.getImage("PaymentMoneyWhite18dp", withColor: UIHelper.GRAPHITE_COLOR) }
        
        if let refund = expense.refundTypeUUID, refund == RefundTypeDataModel.REFUNDABLE {
            cell.refundableImg.isHidden = false
            cell.refundableImg.image = UIHelper.getImage("Refund18dp", withColor: UIHelper.GRAPHITE_COLOR)
        } else { cell.refundableImg.isHidden = true }
        
        if expense.receiptPicUUID != nil
        {
            cell.pictureImg.isHidden = false
            cell.pictureImg.image = UIHelper.getImage("CameraWhite18dp", withColor: UIHelper.GRAPHITE_COLOR)
        } else { cell.pictureImg.isHidden = true }
        
        if let date = expense.date, date > 0 { cell.dateLabel.text = DBManager.formatDateForExpense(DBManager.getNSDateFromMillis(date)) }
        else { cell.dateLabel.text = "" }
        
        if let locationId = expense.vendorUUID {
            if let location = DBManager.getVendor(uuid: locationId) {
                cell.locationLabel.isHidden = false
                cell.locationLabel.text = location.name
            } else { cell.locationLabel.isHidden = true }
        } else { cell.locationLabel.isHidden = true }
        
        if DBManager.isExpenseInReport(expense) {
            let img = UIHelper.getImage("AttachWhite18dp", withColor: UIHelper.GRAPHITE_COLOR)
            cell.attachedImg.isHidden = false
            cell.attachedImg.image = img
        }
        else { cell.attachedImg.isHidden = true }
        
        if let isSync = expense.sync, isSync == 1 {
            cell.isSyncImg.isHidden = false
            cell.isSyncImg.image = UIHelper.getImage("DoneAll18dp", withColor: UIHelper.GRAPHITE_COLOR)
        }
        else { cell.isSyncImg.isHidden = true }
        
        if let _ = expense.routeUUID {
            cell.isRouteImg.isHidden = false
            cell.isRouteImg.image = UIHelper.getImage("MapIcon18dp", withColor: UIHelper.GRAPHITE_COLOR)
        }
        else if expense.web ?? false {
            cell.isRouteImg.isHidden = false
            cell.isRouteImg.image = UIHelper.getImage("Exclamation18dp", withColor: UIHelper.GRAPHITE_COLOR)
        }
        else {
            cell.isRouteImg.isHidden = true
        }
        
        return cell
        
    }
    
}









