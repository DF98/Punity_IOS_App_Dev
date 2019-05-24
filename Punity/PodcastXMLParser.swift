//
//  PodcastXMLParser.swift
//  Punity
//
//  Created by Damian Farinaccio on 24/5/19.
//  Copyright © 2019 Monash University. All rights reserved.
//

import Foundation

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
    
    

