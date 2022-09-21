
import UIKit

class DraggbleView: UIView {
    
    var dragType = DrageType.x
    var superViewSegHeight = CGFloat.zero
     
    init() {
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder: NSCoder) {    // 코드가 아닌 인터페이스(뷰)에서 만들 때, 여기에서 코드 실행.
        fatalError("init(coder:) has not been implemented") // 오직 코드로 만든대로 실행시키기 위해
    }                                                       // 오류 나도록 설정.
    
    @objc func dragging(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            print("began")
        case .changed:
            let delta = pan.translation(in: self.superview)
            var myPosition = self.center
            
            if (dragType == .x) {
                myPosition.x += delta.x
            } else if (dragType == .y) {
                myPosition.y += delta.y
            } else {
                myPosition.x += delta.x
                myPosition.y += delta.y
            }
            
//          if myPosition.y > superViewSegHeight + self.bounds.height/2 {
                self.center = myPosition
//          }
            
            pan.setTranslation(CGPoint.zero, in: self.superview)
            
        case .ended, .cancelled:
            print("ended canceled")
            
            if self.frame.minX < 0 {
                self.frame.origin.x = 0
            }
            
            if let hasSuperView = self.superview {
               if self.frame.maxX > hasSuperView.frame.maxX {
                    self.frame.origin.x = hasSuperView.frame.maxX - self.bounds.width
                }
            }
            
            if self.frame.minY < superViewSegHeight {
                self.frame.origin.y = superViewSegHeight
            }
            
            if let hasSuperView = self.superview {
                if self.frame.maxY > hasSuperView.frame.maxY {
                    self.frame.origin.y = hasSuperView.frame.maxY - self.bounds.height
                }
            }
            
        default:
            break
        }
    }
}
