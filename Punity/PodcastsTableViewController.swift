//
//  PodcastsTableViewController.swift
//  Punity
//
//  Created by Damian Farinaccio on 24/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit



class PodcastsTableViewController: UITableViewController, UISearchResultsUpdating, DatabaseListener{
    
    func onPodcastVideosChange(change: DatabaseChange, podcastVideos: [Video]) {
        
        podcastVids = podcastVideos
        
        tableView.reloadData()
    }
    
    func onUserListChange(change: DatabaseChange, users: [User]) {
        
    }
    
    func onVideoListChange(change: DatabaseChange, videos: [Video]) {
        
    }
    func onPodcastListChange(change: DatabaseChange, podcasts: [Podcast])
    {
        allPodcasts = podcasts
        updateSearchResults(for: navigationItem.searchController!)
        tableView.reloadData()
    }
    

    

let PODCAST_CELL = "podcastCell"

let SECTION_PODCAST = 0;
let SECTION_COUNT = 1;
let CELL_PODCAST = "podcastCell"
let CELL_COUNT = "totalPodcastsCell"
    
var podcastVids: [Video] = []
var allPodcasts: [Podcast] = []
var filteredPodcasts: [Podcast] = []
weak var podcastDelegate: AddPodcastDelegate?
weak var databaseController: DatabaseProtocol?
    
    

    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the database controller once from the App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        
        //let xmlParser = PodcastXMLDecoder()
       //xmlParser.parsePodcastXMLWithURL(url: XML_URL, listener: self)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        filteredPodcasts = allPodcasts
        
        let searchController = UISearchController(searchResultsController: nil);
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Podcasts"
        navigationItem.searchController = searchController
        
        // This view controller decides how the search controller is presented.
        definesPresentationContext = true
        
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }

 
 var listenerType = ListenerType.podcasts
    

    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased(),
            searchText.count > 0 {
            filteredPodcasts = allPodcasts.filter({(podcast: Podcast) -> Bool in
                return podcast.pod_name.lowercased().contains(searchText)
            })
        }
        else {
            filteredPodcasts = allPodcasts;
        }
        
        tableView.reloadData();
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allPodcasts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PODCAST_CELL, for: indexPath) as! PodcastTableViewCell
        
        //let podcast = podcastVids[indexPath.row]
        let podcasts = filteredPodcasts[indexPath.row]
        
        //cell.titleLabel.text = podcast.video_title
        cell.titleLabel.text = podcasts.pod_name
        
        return cell
    }
    
    func onFinishedParse(podcasts: [Podcast]) {
        allPodcasts = podcasts
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "podcastEpisode_Segue"
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let podcast = allPodcasts[indexPath.row]
            let destination = segue.destination as? EpisodesTableViewController
            destination?.podcast = podcast
        }
        
    }
    

}
