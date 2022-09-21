
import UIKit

protocol NaviBarAppearanceDelegate {
    func redesign()
}

class DetailViewController: UIViewController {
    
    var naviBarAppearanceDelegate: NaviBarAppearanceDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviBarAppearanceDelegate?.redesign()

    }
    
//    func redesign() {
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .red
//
//        self.navigationController?.navigationBar.standardAppearance = appearance
//        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        self.navigationController?.navigationBar.compactAppearance = appearance
//    }

}
