//
//  Helper.swift
//  GoodWeatherTutorial
//
//  Created by Ethan on 2020/1/22.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation


class Dynamic<T>:Decodable where T:Decodable {
    
    typealias Listener = (T) ->()
    var listener:Listener?
    
    //要有Value可以使用
    var value:T {
        didSet {
            listener?(value)
        }
    }
    
    init(value:T) {
        self.value = value
    }
    
    //要可以bind listener
     func bind(listener:Listener?){
        self.listener = listener
        self.listener?(value)
    }
    
    //decodable使用
    enum CodingKeys:CodingKey {
        case value
    }
    
}
