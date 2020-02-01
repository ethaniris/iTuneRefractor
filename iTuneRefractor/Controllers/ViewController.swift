//
//  ViewController.swift
//  iTuneRefractor
//
//  Created by Ethan on 2020/1/28.
//  Copyright © 2020 playplay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView:UITableView!
    var songListVM:SongListViewModel?
    var searchController = UISearchController(searchResultsController: nil)
    private var previousRun = Date()
    private let minInterval = 0.05
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearch()
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func setupSearch(){
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Music"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let textToSearch = searchBar.text, !searchText.isEmpty else {return}
        
        if Date().timeIntervalSince(previousRun) > minInterval{
            previousRun = Date()
            fetchSong(textToSearch)
        }
        
    }
    
    func fetchSong(_ text:String) {

        //let searchText = text.replacingOccurrences(of: " ", with: "+")
        
        let st = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://itunes.apple.com/search?term=" + st! + "&limit=30&entity=song")
        
        //        WebService().load(url: url!) { (songData) in
        //            print(songData)
        //        }
        
        let resource = Resource<SongListViewModel>(url: url!)
        WebService().dynamicLoad(resource: resource) {[weak self] (vm) in
            self?.songListVM = vm
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let songListVM = songListVM else { return 0}
        return songListVM.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongTableViewCell
        
        guard let songListVM = songListVM else { return cell}
        cell.songVM = songListVM.results[indexPath.row]
        
       
        return cell
    }
    
}

