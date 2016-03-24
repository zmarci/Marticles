//
//  APIManager.swift
//  APILearning
//
//  Created by Marton Zatrok on 24/03/16.
//  Copyright © 2016 Marton Zatrok. All rights reserved.
//

import Foundation
import SwiftHTTP
import SwiftyJSON

class APIManager
{
    //MARK: Variables
    
    static let sharedInstance   = APIManager()
    private init() {}
    
    let baseURLpreFix           = "http://www.faroo.com/api?q="
    let baseURLpostFix          = "&start=1&length=10&l=en&src=news&f=json"
    let APIKey                  = "&key=-7fVUQwrapqkqjwjN6TCtZiWuko_"
    
    //MARK: HTTP request
    
    func loadArticlesForKeyword(keyword: String) -> [Article]
    {
        let searchURL       = baseURLpreFix + keyword + baseURLpostFix + APIKey
        
        var articleArray    = [Article]()
        
        do
        {
            let opt = try HTTP.New(searchURL, method: .GET, requestSerializer: JSONParameterSerializer())
                opt.start { response in
                
                if let err = response.error
                {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                
                    let json = JSON(data: response.data)
                    
                    if let jsonResultsArray = json["results"].array
                    {
                        for item in jsonResultsArray
                        {
                            
                            guard let domain = item["domain"].string, title = item["title"].string, date = item["date"].double, desc = item["kwic"].string, url = item["url"].string  else
                            {
                                return
                            }
                            
                            var article     = Article()
                            
                            article.domain  = domain
                            article.title   = title
                            article.date    = NSDate(timeIntervalSince1970: date)
                            article.desc    = desc
                            article.url     = url
                            
                            articleArray.append(article)
                        }
                    }
            }
        }
        catch let error
        {
            print("got an error creating the request: \(error)")
        }
        
        return articleArray
    }
}