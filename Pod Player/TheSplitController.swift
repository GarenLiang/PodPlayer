//
//  TheSplitController.swift
//  Pod Player
//
//  Created by GarenLiang on 2017/5/10.
//  Copyright © 2017年 GarenLiang. All rights reserved.
//

import Cocoa

class TheSplitController: NSSplitViewController {

    @IBOutlet weak var podcastsItem: NSSplitViewItem!
    
    @IBOutlet weak var episodesItem: NSSplitViewItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        if let podcastsVC = podcastsItem.viewController as? PodcastsViewController {
            if let episodesVC = episodesItem.viewController as? EpisodesViewController {
                podcastsVC.episodesVC = episodesVC
                episodesVC.podcastsVC = podcastsVC
        }
    }
    
}
}
