//
//  APIManager.swift
//  AIR
//
//  Created by alfonso on 04/09/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    
    // Singleton
    static let shared = APIManager()
    
    // Endpoints
    let phpURL1 = "https://api.rss2json.com/v1/api.json?rss_url=http%3A%2F%2Ffetchrss.com%2Frss%2F5babd93b8a93f8a0228b4567964029246.xml"
   
    
    func aggiornaAvvisi(onSuccess: @escaping(FeedResponse) -> Void, onFailure: @escaping(Error) -> Void) {
        
        // Configuration
        
        let url = URL(string: phpURL1)!
        let requestURL = URLRequest(url: url)
        let session = URLSession.shared
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.dateStyle = .short
        
        
        // Session
        session.dataTask(with: requestURL) { (data, response, error) in
            guard error == nil else {
                onFailure(error!)
                return
            }
            do {
               
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let payload = try decoder.decode(FeedResponse.self, from: data!)
                onSuccess(payload)
            } catch let error {
                print(error)
                onFailure(error)
                
            }
        }.resume()
    }
}

struct FeedResponse: Codable{
    
    struct Feed:Codable {
        var url:String
        var title:String
        var link:String
        var author:String
        var description:String
     
        
        enum CodingKeys:String,CodingKey{
            case url = "url"
            case title = "title"
            case link = "link"
            case author = "author"
            case description = "description"
          
        }
    }
    
    struct Item: Codable {
        var title:String
        var pubDate:String
        var link:String //Download PDF
        var description:String
        
  
        
        enum CodingKeys: String,CodingKey{
            case title = "title"
            case pubDate = "pubDate"
            case link = "link"
            case description = "description"
            
        }
        
    }
    
    enum CodingKeys:String,CodingKey{
        case status = "status"
        case feed = "feed"
        case items = "items"
    }
    var status: String
    var feed:Feed
    var items:[Item]
}




