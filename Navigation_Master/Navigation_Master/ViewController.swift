
import UIKit
 
class ViewController: UIViewController {
    
    let appearance = UINavigationBarAppearance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviTitleImage()
        
        makeBackButton()
        
        naviBackgroundDesign()
        
        makeRightAlarmButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeBackButton()
        naviBackgroundDesign()
    }
    
    func makeRightAlarmButton() {
//        let image = UIImage(systemName: "alarm.fill")?.withRenderingMode(.alwaysOriginal)
//
//        let rightItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(rightItemClick))
//
//        let image2 = UIImage(systemName: "alarm")?.withRenderingMode(.alwaysOriginal)
//
//        let rightItem2 = UIBarButtonItem(image: image2, style: .done, target: self, action: #selector(rightItemClick2))
//        r
//        ightItem2.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
//
//        self.navigationController?.navigationBar.topItem?.rightBarButtonItems = [rightItem, rightItem2]
        
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        
        let btn1 = UIButton()
        btn1.setImage(UIImage(systemName: "alarm.fill", withConfiguration: config), for: .normal)
        btn1.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        
        let btn2 = UIButton()
        btn2.setImage(UIImage(systemName: "alarm"), for: .normal)
        btn2.addTarget(self, action: #selector(rightItemClick2), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [btn1, btn2])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        
        let customItem = UIBarButtonItem(customView: stackView)
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = customItem
    }
    
    @objc func rightItemClick() {
        print("right item click")
    }
    
    @objc func rightItemClick2() {
        print("right item2 click")
    }
    
    func naviBackgroundDesign() {
        appearance.backgroundEffect = .init(style: .extraLight)
        appearance.backgroundColor = .blue.withAlphaComponent(0.2)

        let mainImage = UIImage(named: "logoSample")?.withRenderingMode(.alwaysOriginal)
        let newImage = resizeImage(image: mainImage, newWidth: 40, newHeight: 40)
        appearance.backgroundImage = newImage
        appearance.backgroundImageContentMode = .bottom

        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        
    }
    
    func makeBackButton() {
//        self.navigationItem.backButtonTitle = "뒤로"
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(systemItem: .bookmarks)
        
//        var backImage = UIImage(systemName: "backward.fill")
//        backImage = backImage?.withRenderingMode(.alwaysOriginal)
        
        let backImage = UIImage(named: "logoSample")?.withRenderingMode(.alwaysOriginal)
        
        guard let newImage = resizeImage(image: backImage, newWidth: 40, newHeight: 40) else {
            return
        }
        
//        self.navigationController?.navigationBar.backIndicatorImage = newImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = newImage
//        self.navigationController?.navigationBar.tintColor = .orange
        
        appearance.setBackIndicatorImage(newImage, transitionMaskImage: newImage)
        
    }
    
    func resizeImage(image: UIImage?, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
    
        let newRect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image?.draw(in: newRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    func setNaviTitleImage() {
        
//        self.navigationItem.title = "Main view"
                    
//        let logo = UIImageView(image: UIImage(named: "logoSample.jpg"))
//
//        logo.contentMode = .scaleAspectFit
//        logo.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//        navigationItem.titleView = logo
                    
        let btn = UIButton()
     // btn.backgroundColor = .orange
        btn.setTitleColor(.blue, for: .normal)
        btn.setTitle("custom button", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.addTarget(self, action: #selector(testAction), for: .touchUpInside)
                    
        self.navigationItem.titleView = btn
    }
    
    @objc func testAction () {
        print("test action")
    }

    @IBAction func showDetailVC(_ sender: Any) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.naviBarAppearanceDelegate = self
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

extension ViewController: NaviBarAppearanceDelegate {
    func redesign() {
        appearance.backgroundColor = .red.withAlphaComponent(0.2)
        appearance.backgroundImage = nil
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
    }
    
    
}
