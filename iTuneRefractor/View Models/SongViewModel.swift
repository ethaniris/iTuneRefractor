//
//  SongViewModel.swift
//  iTuneRefractor
//
//  Created by Ethan on 2020/1/28.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation


class SongListViewModel:Decodable{
    let results:[SongViewModel]
}



class SongViewModel:Decodable{
    
    let artistName:Dynamic<String>
    let songName:Dynamic<String>
    let albumImageURL:Dynamic<String>
    
    private enum CodingKeys:String, CodingKey{
        case artistName
        case songName = "trackName"
        case albumImageURL = "artworkUrl100"
    }
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        artistName = Dynamic(value: try container.decode(String.self, forKey: .artistName))
        songName = Dynamic(value: try container.decode(String.self, forKey: .songName))
        albumImageURL = Dynamic(value: try container.decode(String.self, forKey: .albumImageURL))
    }
    
}

