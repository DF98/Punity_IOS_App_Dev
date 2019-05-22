//
//  ViewController.swift
//  Punity
//
//  Created by Damian Farinaccio on 13/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
   
    
    @IBOutlet weak var test_lbl: UILabel!
    weak var databaseController: DatabaseProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        test_lbl.text = databaseController?.getVideoByID(reference:"3t3bbtblaZquX4o5cud0")?.video_title
       
    }
    
    
    

}

