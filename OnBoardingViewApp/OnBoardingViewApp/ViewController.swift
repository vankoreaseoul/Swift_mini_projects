
import UIKit

class ViewController: UIViewController {
    
    var didShowOnBoardingView = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if didShowOnBoardingView == false {
            didShowOnBoardingView = true
            
            let onBoardingPageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            
            onBoardingPageVC.modalPresentationStyle = .fullScreen
            
            self.present(onBoardingPageVC, animated: true, completion: nil)
        }
    }


}

