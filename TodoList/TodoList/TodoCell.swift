
import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var priorityView: UIView!
    
    @IBOutlet weak var topTitleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
