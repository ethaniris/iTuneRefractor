//
//  SongData.swift
//  iTuneRefractor
//
//  Created by Ethan on 2020/1/28.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation



class SongListData:Decodable {
    let results:[SongData]
}

class SongData:Decodable{
    
    let artistName:String
    let songName:String
    let albumImageURL:String
    
    private enum CodingKeys:String, CodingKey{
        case artistName, songName = "trackName", albumImageURL = "artworkUrl100"
    }
    
}
