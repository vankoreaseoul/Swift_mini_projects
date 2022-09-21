
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customButton: RotateButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customButton.selectTypeCallback = { upDownType in
            print(upDownType)
        }
        
        
        
        
//        let myButton = RotateButton()
//
//        self.view.addSubview(myButton)
        
//        myButton.translatesAutoresizingMaskIntoConstraints = true
//        myButton.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        
        
        
        
//        myButton.translatesAutoresizingMaskIntoConstraints = false
//
//        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//
//        myButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
//        myButton.backgroundColor = UIColor.orange
//        myButton.setTitle("my custom button", for: .normal)
//        myButton.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        
        
    }


}

