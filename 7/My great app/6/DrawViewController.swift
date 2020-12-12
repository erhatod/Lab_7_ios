//
//  DrawViewController.swift
//  My great app
//
//  Created by Oleksii Afonin on 06.12.2020.
//

import UIKit

class DrawViewController: UIViewController {

    @IBOutlet weak var segmentedContreol: UISegmentedControl!
    
    @IBOutlet weak var customView: CustomView!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func segValueDidChanged(_ sender: UISegmentedControl) {
        customView.drapDiagram.toggle()
    }
}
// segmentedContreol
