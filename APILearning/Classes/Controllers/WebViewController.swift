//
//  WebViewController.swift
//  APILearning
//
//  Created by Marton Zatrok on 24/03/16.
//  Copyright © 2016 Marton Zatrok. All rights reserved.
//

import UIKit

class WebViewController: UIViewController
{
    //MARK: Variables
    
    var articleURL = String()
    
    //MARK: IBOutlets
    
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: Life-cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        setupViews()
    }
    
    //MARK: IBActions
    
    //MARK: Initialization
    
    func setupViews()
    {
        guard let URL = NSURL(string: articleURL) else
        {
            return
        }
        webView.loadRequest(NSURLRequest(URL: URL))
    }
}
