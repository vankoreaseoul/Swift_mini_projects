//
//  ViewController.swift
//  App_Start
//
//  Created by Heawon Seo on 12/08/2022.
//

import UIKit

// 실행 - command + R

class ViewController: UIViewController {
    // View Contoller life cycle
    
    @IBOutlet weak var testButton: UIButton!
    
    @IBAction func doSomething(_ sender: Any) {
        testButton.backgroundColor = .orange
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testButton.backgroundColor = .red
    }


}

