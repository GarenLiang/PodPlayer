//
//  PodcastsViewController.swift
//  Pod Player
//
//  Created by GarenLiang on 2017/5/6.
//  Copyright © 2017年 GarenLiang. All rights reserved.
//

import Cocoa

class PodcastsViewController: NSViewController {

    @IBOutlet weak var podcastURLTextField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        podcastURLTextField.stringValue = "http://www.espn.com/espnradio/podcast/feeds/itunes/podCast?id=2406595"
    }
    func getPodcasts() {
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext
 {
            let fetchy = Podcast.fetchRequest() as NSFetchRequest<Podcast>
            fetchy.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            do {
                let podcasts = try context.fetch(fetchy)
                print(podcasts)
            } catch {}
        }
    }
    
    @IBAction func addPodcastClicked(_ sender: Any) {
        if let url = URL(string: podcastURLTextField.stringValue) {
            URLSession.shared.dataTask(with: url ) {
                (data:Data?, response: URLResponse?,
                 error:Error?) in
                if error != nil {
                    print(error)
                } else {
                    if data != nil {
                        let parser = Parser()
                        let info = parser.getPodcastMetaData(data: data!)
                        
                        if let context = (NSApplication.shared().delegate as?
                            AppDelegate)?.persistentContainer.viewContext
 {
                            let podcast = Podcast(context: context)
                            
                            podcast.rssURL = self.podcastURLTextField.stringValue
                            podcast.imageURL = info.imageURL
                            podcast.title = info.title
                            
                            (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
                            self.getPodcasts()
                        }
                    }
                }
            }.resume()
            podcastURLTextField.stringValue = ""
        }
        
    }
}
