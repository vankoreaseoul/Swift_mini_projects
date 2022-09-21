
import UIKit

enum DrageType {
    case x
    case y
    case none
}

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    var dragType = DrageType.none
    let myView = DraggbleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.center = self.view.center
        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.backgroundColor = .red
        
        self.view.addSubview(myView)
        
        myView.superViewSegHeight = getStatusBarHeight() + segmentedControll.bounds.height
    }


    @IBAction func selectPanType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            dragType = .x
        case 1:
            dragType  = .y
        case 2:
            dragType  = .none
        default:
            break
        }
        myView.dragType = self.dragType
    }
    
    func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight
    }
    
   
    
}

