

import UIKit

class ExpenseTableViewHeader: UIView {
    
    var section: Int?
    var delegate: HeaderClickProtocol?
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var dateTitle: UILabel!
    @IBOutlet var arrowIcon: UIImageView!
    
    func toggleArrowIcon(_ open: Bool){
        if open {
            arrowIcon.image = UIImage(named: "ArrowRight24dp")
        } else {
            arrowIcon.image = UIImage(named: "ArrowDownIcon")
        }
    }
    
    class func instanceFromNib() -> ExpenseTableViewHeader {
        return UINib(nibName: "ExpenseTableViewHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ExpenseTableViewHeader
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol HeaderClickProtocol {
    
    func headerClick(_ sectionIndex: Int)
}
