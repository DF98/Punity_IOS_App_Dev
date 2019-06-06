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
    
    weak var podcast: Podcast?
    var podcastVids: [Video] = []
    var numOfRows: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        var episodeTitle = ""

        let url = "http://joeroganexp.joerogan.libsynpro.com/rss"
        
        RSSParser.getRSSFeedResponse(path: url) { (rssFeed: RSSFeed?, status: NetworkResponseStatus) in
            
            
        }
                
        
    
        // Configure the cell...
        cell.textLabel?.text = episodeTitle
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func setNumOfRows (int: Int)
    {
        numOfRows = int
    }

}
