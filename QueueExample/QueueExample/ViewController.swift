 
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var finishLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            
            self.timerLabel.text = Date().timeIntervalSince1970.description
        }
        
    }
    
    @IBAction func action1(_ sender: Any) {
        simpleClosure {
            self.finishLabel.text = "끝"
        }
    }
    
    func simpleClosure(completion: @escaping () -> Void) {
        
        DispatchQueue.global().async {
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
        }       
        
    }
    
 
    @IBAction func action2(_ sender: Any) {
        let dispatchGroup = DispatchGroup()

        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        let queue3 = DispatchQueue(label: "q3")

        queue1.async(group: dispatchGroup, qos: .background) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }

        queue2.async(group: dispatchGroup, qos: .userInteractive) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }

        queue3.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 20..<30 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("끝")
        }
    }

    @IBAction func action3(_ sender: Any) {
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        
        queue1.sync {
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
            
                // deadlock -> 상태 작업이 끝날 때까지 서로 계속 기다리는 상태
                queue1.sync {
                        for index in 10..<20 {
                            Thread.sleep(forTimeInterval: 0.2)
                            print(index)
                        }
                }
        }

        
        
    }
    
 
    
    
}

