//
//  DemoURL.swift
//  Cassini
//
//  Created by Glaphi on 30/10/2017.
//  Copyright © 2017 glaphi. All rights reserved.
//

import Foundation

struct DemoURL
{
    static let stanford = URL(string: "http://thejizn.com/wp-content/uploads/2016/05/photo-epel-stanford-campus.jpg")
    
    static var NASA: Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini" : "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth" : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}

