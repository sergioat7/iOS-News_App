//
//  ErrorController.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ErrorController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    init(){
        super.init(nibName: "ErrorView", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.attributedText = NSAttributedString(string: errorLabel.text!, attributes: [.font: UIFont.robotoRegular18, .foregroundColor: UIColor.negro])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationDrawerController?.isLeftPanGestureEnabled = false
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func goBack(_ sender: Any) {
        AppDelegate.sharedAppDelegate().setRootViewController(MainViewController())
    }
}
