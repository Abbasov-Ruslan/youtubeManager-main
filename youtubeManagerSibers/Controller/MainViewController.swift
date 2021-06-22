//
//  MainViewController.swift
//  youtubeManagerSibers
//
//  Created by Ruslan Abbasov on 12.06.2021.
//

import Foundation
import UIKit
import WebKit

class MainViewController: UIViewController {

    
    var videoID: String = ""
    
    var descriptionString = ""
    
    var titleString = ""
    
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionView.layer.borderWidth = 1
        descriptionView.layer.borderColor = UIColor.black.cgColor
        
        descriptionLabel.text = descriptionString
        
        titleLabel.text = titleString
        
        let url = "http://www.youtube.com/embed/" + videoID
        
        webView.load(NSURLRequest(url: NSURL(string: url)! as URL) as URLRequest)
    }
}

