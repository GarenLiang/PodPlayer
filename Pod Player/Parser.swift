//
//  Parser.swift
//  Pod Player
//
//  Created by GarenLiang on 2017/5/6.
//  Copyright © 2017年 GarenLiang. All rights reserved.
//

import Foundation

class Parser {
    func getPodcastMetaData(data:Data) -> (title:String?, imageURL:String?) {
        let xml = SWXMLHash.parse(data)
        
        print(xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
        
        return (xml["rss"]["channel"]["title"].element?.text, xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text    )
    }
}
