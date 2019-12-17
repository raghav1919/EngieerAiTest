//
//  NetworkManager.swift
//  EngieerAIAssignment
//
//  Created by kushal mandala on 17/12/19.
//  Copyright © 2019 kushal mandala. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    static func getposts(_ url:String,finish:@escaping(Posts)->Void)
    {
        URLSession.shared.dataTask(with: URL(string: url)!) { (Data, URLResponse, Error) in
            
            guard Data != nil else
            {
                return
            }
            
            do{
                
                let jsonDecoder = JSONDecoder()
                let postInfo = try jsonDecoder.decode(Posts.self, from: Data!)
                finish(postInfo)
                            
            }
            catch
            {
                print("error is \(String(describing: Error))")
            }
            
        }.resume()
    }

}
