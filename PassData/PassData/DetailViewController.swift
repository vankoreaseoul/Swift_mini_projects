//
//  DetailViewController.swift
//  PassData
//
//  Created by Heawon Seo on 13/08/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var someString = ""
    
    @IBOutlet weak var someLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        someLabel.text = someString
    }



}
