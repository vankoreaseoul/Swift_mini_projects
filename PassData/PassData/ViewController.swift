
// passing data (데이터를 넘겨주는 방법)
// 6가지

// 1. instance property
// 2. segue
// 3. instance
// 4. delegate (delegation) pattern 대리 위임 대신
// 5. closure
// 6. Notification  -> 연결점이 없을 때, 사용 용이!

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationName = Notification.Name("sendSomeString")
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendSomeString), name: notificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    
    }
    
    @objc func keyboardDidShow() {
        print("did show")
    }
    
    @objc func keyboardWillShow() {
        print("will show")
    }
    
    @objc func sendSomeString(notification: Notification) {
        if let str = notification.userInfo?["str"] as? String {
            self.dataLabel.text = str
        }
    }
    
    
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            if let segueDetailViewConroller = segue.destination as? SegueDetailViewController {
                  segueDetailViewConroller.dataString = "abcd"
            }
        }
    }

    @IBAction func moveToDetail(_ sender: Any) {
        let detailViewContoller = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        detailViewContoller.someString = "data"
        
        self.present(detailViewContoller, animated: true, completion: nil)
    }
    
    @IBAction func moveToInstance(_ sender: Any) {
        let instanceDetailViewController = InstanceDetailViewController(nibName: "InstanceDetailViewController", bundle: nil)
        
        instanceDetailViewController.mainVC = self
        
        self.present(instanceDetailViewController, animated: true, completion: nil)
    }
    
    @IBAction func moveToDelegate(_ sender: Any) {
        let delegateDetailViewController = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        
        delegateDetailViewController.delegate = self
        
        self.present(delegateDetailViewController, animated: true, completion: nil) 
    }
    
    @IBAction func moveToClosure(_ sender: Any) {
        let closureDetailViewController = ClosureDetailViewController(nibName: "ClosureDetailViewController", bundle: nil)
        
        closureDetailViewController.myClosure = { str in
            self.dataLabel.text = str
        }
        
        self.present(closureDetailViewController, animated: true, completion: nil)
    }
    
    @IBAction func moveToNotification(_ sender: Any) {
        let notificationDetailViewController = NotificationDetailViewController(nibName: "NotificationDetailViewController", bundle: nil)
        
        self.present(notificationDetailViewController, animated: true, completion: nil)
    }
    
}


extension ViewController: DelegateDetailViewControllerDelegate {
    func passString(string: String) {
        dataLabel.text = string
    }
       
}

