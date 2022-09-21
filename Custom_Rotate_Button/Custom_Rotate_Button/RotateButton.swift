
import UIKit
 
enum RotateType {
    case up
    case down
}

class RotateButton: UIButton {
      
    private var isUp = RotateType.up {
        didSet {
            changeDesign()
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure() 
    }
    
    
    var selectTypeCallback: ((RotateType) -> Void)?
    
    
    private func configure() {
        self.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
    }
    
    @objc private func selectButton() {
        if isUp == .up {
            isUp = .down
        } else {
            isUp = .up
        }
        
        selectTypeCallback?(isUp)  
    }
    
    private func changeDesign() {
        
        UIView.animate(withDuration: 1) {
            if self.isUp == .down {
                self.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
            } else {
                self.imageView?.transform = .identity // 원상복귀
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
        }
        
    }
    
    
}
