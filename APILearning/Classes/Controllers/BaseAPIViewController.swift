//
//  BaseAPIViewController.swift
//  APILearning
//
//  Created by Marton Zatrok on 24/03/16.
//  Copyright © 2016 Marton Zatrok. All rights reserved.
//

import UIKit

class BaseAPIViewController: UIViewController
{
    //MARK: Variables
    
    private var articleArray        = [Article]()
    
    private var cellIdentifier      = ""
    private var articleCellID       = "ArticleCell"
    
    private var articleCellHeight   : CGFloat = 150
    
    private let webSegue            = "webSegue"
    
    private var selectedArticle     : Article?
    
    //MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Life-cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        APIManager.sharedInstance.loadArticlesForKeyword("budapest") { (result) -> Void in
            
            self.articleArray = result
            
            let sections = NSIndexSet(indexesInRange: NSMakeRange(0, self.tableView.numberOfSections))
            self.tableView.reloadSections(sections, withRowAnimation: .Automatic)
        }
        setupViews()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    //MARK: IBActions
    
    //MARK: Initialization

    func setupViews()
    {
        //TABLEVIEW
        automaticallyAdjustsScrollViewInsets = false
        
        //DELEGATION
        tableView.delegate      = self
        tableView.dataSource    = self
    }
    
    //MARK: Segue Handling
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == webSegue
        {
            guard let destinationVC = segue.destinationViewController as? WebViewController, article = selectedArticle else
            {
                return
            }
            destinationVC.articleURL = article.url
        }
    }
}

//MARK: Extensions

//MARK: UITableViewDelegate
extension BaseAPIViewController: UITableViewDelegate
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
            case 0:
                return articleArray.count
            default:
                return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch indexPath.section
        {
            case 0:
                return articleCellHeight
            default:
                return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selectedArticle = articleArray[indexPath.row]
        performSegueWithIdentifier(webSegue, sender: self)
    }
}

//MARK: UITableViewDataSource
extension BaseAPIViewController: UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        cellIdentifier = articleCellID
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? ArticleCell
        if cell == nil
        {
            cell = ArticleCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        let article             = articleArray[indexPath.row]
        cell?.contentLabel.text = article.desc
        cell?.titleLabel.text   = article.title
        cell?.urlLabel.text     = article.url
        
        return cell!
    }
}

