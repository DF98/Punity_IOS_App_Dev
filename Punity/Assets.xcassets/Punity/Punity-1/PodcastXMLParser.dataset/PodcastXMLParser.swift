//
//  PodcastXMLParser.swift
//  Punity
//
//  Created by Damian Farinaccio on 24/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Alamofire
import AlamofireRSSParser

//code sourced from https://www.iosapptemplates.com/blog/swift-programming/implement-rss-feed-parser-swift
public enum NetworkResponseStatus {
    case success
    case error(string: String?)
}

public class RSSParser {
    public static func getRSSFeedResponse(path: String, completionHandler: @escaping (_ response: RSSFeed?,_ status: NetworkResponseStatus) -> Void) {
        Alamofire.request(path).responseRSS() { response in
            if let rssFeedXML = response.result.value {
                // Successful response - process the feed in your completion handler
                completionHandler(rssFeedXML, .success)
            } else {
                // There was an error, so feel free to handle it in your completion handler
                completionHandler(nil, .error(string: response.result.error?.localizedDescription))
            }
        }
    }
}





/*
 THIS CODE WAS TO ATTEMPT PARSSING XML MANUALLY, IF I GET LIBRARY TO WORK THIS CODE WILL BE DELETED.
protocol PodcastParserDelgate {
    func onFinishedParse(podcasts: [Podcast] )
}

class PodcastXMLDecoder: NSObject,XMLParserDelegate
{
    let ROOT_ELEMENT = "channel"
    let PODCAST_EPISODE_ELEMENT = "item"
    let PODCAST_EPISODE_TITLE_ELEMENT = "title"
    let PODCAST_PUBDATE_ELEMENT = "pubdate"
    
    var parser: XMLParser?
    var podcasts: [Podcast] = []
    var currentElement: String?
    var tempPodcast = Podcast()
    var listener: PodcastParserDelgate?
    
    func parsePodcastXMLWithURL(url: String, listener: PodcastParserDelgate)
    {
        self.listener = listener
        
        let xmlURL = URL(string: url.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)!)
        let task = URLSession.shared.dataTask(with: xmlURL!){ (data, response,
            error) in
            if let _ = error {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            self.parser = XMLParser(data: data!)
            self.parser?.delegate = self
            self.parser?.parse()
        }
        task.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?, attributes
        attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        // New book has been started so create a temp book
        if(elementName == PODCAST_EPISODE_ELEMENT) {
            tempPodcast = Podcast()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in:
            CharacterSet.whitespacesAndNewlines)
        
        if(data.isEmpty) {
            return
        }
        
        switch currentElement {
        case PODCAST_EPISODE_TITLE_ELEMENT:
            tempPodcast.pod_name = data
            print(data)
        default:
            print(data)
    
        }
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?) {
        
        // Podcast has finished so save it
        if(elementName == PODCAST_EPISODE_ELEMENT) {
            podcasts.append(tempPodcast)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        listener?.onFinishedParse(podcasts: podcasts)
    }
    
    
}
 */
    
    

