
import UIKit

class MyIDViewController: UIViewController {

    @IBOutlet weak var walletImage: UIImageView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageImage.layer.cornerRadius = 5
        walletImage.layer.cornerRadius = 5
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        textFieldDidChange(sender: emailTextField)
        
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        if sender.text?.isEmpty == true {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }

    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
