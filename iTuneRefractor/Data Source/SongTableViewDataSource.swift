//
//  SongTableViewDataSource.swift
//  iTuneRefractor
//
//  Created by Ethan on 2020/1/28.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation
import UIKit

class SongTableViewDataSource:NSObject, UITableViewDataSource {
    
    var songListVM:SongListViewModel?
    
    init(_ songListVM: SongListViewModel?){
        self.songListVM = songListVM
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songListVM?.results.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell
        
        guard let songListVM = songListVM else { return cell}
       
        cell.songVM = songListVM.results[indexPath.row]

        return cell
        
    }
}
