//
//  APIManager.swift
//  APILearning
//
//  Created by Marton Zatrok on 24/03/16.
//  Copyright © 2016 Marton Zatrok. All rights reserved.
//

import Foundation
import SwiftHTTP

class APIManager
{
    //MARK: Variables
    
    let baseURLpreFix   = "http://www.faroo.com/api?q="
    let baseURLpostFix  = "&start=1&length=10&l=en&src=news&f=json"
    var searchKeyWord   = "budapest"
    
    //MARK: HTTP request
    
    func downloadShit()
    {
        let searchURL = baseURLpreFix + searchKeyWord + baseURLpostFix
        
        do
        {
            let opt = try HTTP.GET(searchURL)
            opt.start { response in
                
                if let err = response.error
                {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                //print("data is: \(response.data)") access the response of the data with response.data
            }
        }
        catch let error
        {
            print("got an error creating the request: \(error)")
        }
    }
}