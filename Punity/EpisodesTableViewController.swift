//
//  EpisodesTableViewController.swift
//  Punity
//
//  Created by Damian Farinaccio on 22/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireRSSParser

class EpisodesTableViewController: UITableViewController {
   
    let EPISODE_CELL = "episodeCell"
    
    weak var podcast: Podcast?
    var podcastVids: [Video] = []
    var numOfRows: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        RSSParser.getRSSFeedResponse(path: "http://joeroganexp.joerogan.libsynpro.com/rss") { (rssFeed: RSSFeed?, status: NetworkResponseStatus) in
            for item in rssFeed!.items{
               let newVideo = Video()
                newVideo.video_title = item.title!
                newVideo.video_link = item.link!
                newVideo.video_desc = item.itemDescription!
                
                
                
                self.podcastVids.append(newVideo)
                
            }
            self.tableView.reloadData()
        }
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return podcastVids.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        /*
        let url = "http://joeroganexp.joerogan.libsynpro.com/rss"
        
        Alamofire.request(url).responseRSS() { (response) -> Void in
            if let feed: RSSFeed = response.result.value {
                self.setNumOfRows(int: feed.items.count)
                print("Number Of Rows Value inside brackets: \(self.numOfRows)")
            }
        }
        
        print("Number Of Rows Value: \(self.numOfRows)")
         */
        return podcastVids.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: self.EPISODE_CELL, for: indexPath) as! EpisodeTableViewCell
        
        // Configure the cell...
        if (podcastVids.count > 0){
        cell.titleLabel.text = podcastVids[indexPath.row].video_title
        }
        
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        
        if segue.identifier == "episodeToPlayer_Segue"
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let video = podcastVids[indexPath.row]
            let destination = segue.destination as? VideoViewController
            destination?.video = video
        }
    }
 
    
    func onFinishedParse(episodes: [Video]) {
        podcastVids = episodes
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    

}
