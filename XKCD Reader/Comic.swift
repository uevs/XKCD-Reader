//
//  Comic.swift
//  XKCD Reader
//
//  Created by leonardo on 12/04/22.
//

import Foundation

struct Comic: Decodable, Encodable, Hashable {
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
    
    func formatDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.date(from: "\(day)/\(month)/\(year)")!
    }
    
    func findLink() -> URL {
        URL(string: link ?? "https://xkcd.com/") ?? URL(string: "https://xkcd.com/")!
    }
    
    func isFavorite(favorites: [Comic]) -> Bool {
        if favorites.contains(where: {$0.num == self.num}) {
            return true
        }
        return false
    }
}


