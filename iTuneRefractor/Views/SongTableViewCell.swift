//
//  SongTableViewCell.swift
//  iTuneRefractor
//
//  Created by Ethan on 2020/1/28.
//  Copyright © 2020 playplay. All rights reserved.
//

import Foundation
import UIKit

class SongTableViewCell:UITableViewCell {
    
    @IBOutlet weak var albumImageView:UIImageView!
    @IBOutlet weak var artistNameLabel:UILabel!
    @IBOutlet weak var songNameLabel:UILabel!
    
//    var songVM:DSongData? {
//        didSet{
//            self.songVM?.songName.bind(listener: {[weak self] (string) in
//                self?.songNameLabel.text = string
//            })
//
//            self.songVM?.artistName.bind(listener: {[weak self] (string) in
//                           self?.artistNameLabel.text = string
//                       })
//
//            self.songVM?.albumImageURL.bind(listener: {[weak self] (string) in
//                self?.albumImageView.downloadFrom(link: string, contentMode: .scaleAspectFit)
//            })
//
//        }
//
//    }
    
    var songVM:SongViewModel? {
        didSet{
            
            
            self.songVM?.songName.bind(listener: {[weak self] (string) in
                self?.songNameLabel.text = string
            })
            
             self.songVM?.artistName.bind(listener: {[weak self] (string) in
                           self?.artistNameLabel.text = string
                       })
            
            self.songVM?.albumImageURL.bind(listener: {[weak self] (string) in
                self?.albumImageView.downloadFrom(link: string, contentMode: .scaleAspectFit)
            })

        }

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumImageView.image = nil

    }


}

extension UIImageView
{
    func downloadFrom(link:String?, contentMode mode: UIView.ContentMode)
    {
        contentMode = mode
        if link == ""
        {
            self.image = UIImage()
            return
        }
        if let url = NSURL(string: link!)
        {
           
            URLSession.shared.dataTask(with: url as URL, completionHandler: { [weak self] (data, _, error) -> Void in
                guard let data = data, error == nil else {
  
                    return
                }
                DispatchQueue.main.sync() { () -> Void in
           
                    self?.image = UIImage(data: data)
                }
            }).resume()
        }
        else
        {
            self.image = UIImage()
        }


    }
}
