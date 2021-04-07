

import UIKit

class ExpenseCell: UITableViewCell {
    
    @IBOutlet var picImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    
    
    
    @IBOutlet var isExpenseInReportImg: UIImageView!
    @IBOutlet var paymentTypeImg: UIImageView!
    @IBOutlet var refundTypeImage: UIImageView!
    @IBOutlet var picAvailableImg: UIImageView!
    @IBOutlet var isCorporateImgView: UIImageView!
    @IBOutlet var isSyncImageView: UIImageView!
    
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
