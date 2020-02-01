//
//  WebService.swift
//  iTuneRefractor
//
//  Created by Ethan on 2020/1/28.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation

struct Resource<T:Decodable> {
    let url:URL
    
}


class WebService {
    
    func dynamicLoad<T>(resource:Resource<T>, completion: @escaping (T?) -> ()) {
            
            
            URLSession.shared.dataTask(with: resource.url) { data, respose, error in
                
                if let data = data {
                         print(data)
                    let parseData = try? JSONDecoder().decode(T.self, from: data)
               
                    print(parseData)
                    completion(parseData)

                } else {
                    
                    completion(nil)
                
                }
                
            }.resume()
            
        }
        
    
    
    func load(url:URL, completion:@escaping([SongViewModel]) ->()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil{
                print(error?.localizedDescription)
                return
            }
         
            if let data = data {
          
                do {
                    let songData = try JSONDecoder().decode(SongListViewModel.self, from: data)
                    completion(songData.results)
                    
                } catch {
                    print(error.localizedDescription)
                    
                }
                
            }
            
        }.resume()
        
    }
}
