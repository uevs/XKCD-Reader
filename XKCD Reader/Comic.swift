//
//  Comic.swift
//  XKCD Reader
//
//  Created by leonardo on 12/04/22.
//

import Foundation

struct Comic: Decodable, Encodable {
    var title: String
    var safe_title: String
    var num: Int
    var alt: String
    var news: String?
    var transcript: String?

    var day: String
    var month: String
    var year: String
    
    var img: String
    var link: String?
}


