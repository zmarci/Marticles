//
//  ArticleCell.swift
//  APILearning
//
//  Created by Marton Zatrok on 24/03/16.
//  Copyright © 2016 Marton Zatrok. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell
{
    //MARK: Variables
    
    //MARK: IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    //MARK: Life-cycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func prepareForReuse()
    {
        titleLabel.text = ""
    }
    
    //MARK: IBActions
    
}
