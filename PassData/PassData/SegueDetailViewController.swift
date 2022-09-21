//
//  SegueDetailViewController.swift
//  PassData
//
//  Created by Heawon Seo on 13/08/2022.
//

import UIKit

class SegueDetailViewController: UIViewController {
    
    var dataString = ""

    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataLabel.text = dataString
    }
    


}
