//
//  ComicViewModel.swift
//  XKCD Reader
//
//  Created by leonardo on 12/04/22.
//

import Foundation
import SwiftUI



class Comics: ObservableObject {
    /// The app ViewModel responsible for making API calls, storing and loading data from UserDefaults.
    /// The fetched comics JSON files are stored on UserDefaults to ensure no useless API calls are made, once they have been fetched once they are not going to be fetched again.
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    /// Comics and favorites are retrieved from the API or UserDefaults and are stored here at runtime.
    @Published var comics: [Comic] = []
    @Published var favorites: [Comic] = []
    
    var latestComicPublished: Int = 2613 // Hardcoded as a failsafe.
    var latestComicSaved: Int?
    
    init() {
        
        /// Checks if there are comics stored, if so it decodes them and loades them in the comics array
        if let comicsStored = UserDefaults.standard.data(forKey: "comics") {
            print("Found comics")
            latestComicPublished = UserDefaults.standard.integer(forKey: "latestComicPublished")
            latestComicSaved = UserDefaults.standard.integer(forKey: "latestComicSaved")
            
            do {
                let decodedComics = try decoder.decode([Comic].self, from: comicsStored)
                comics = decodedComics
                print("Comics loaded.")
                
            } catch {
                print("Can't decode stored comics.")
            }
            
            /// Checks if new comics have been published since the last opening of the app and updates the array
            Task {
                let currentLast = await fetchLatest()
                
                if currentLast != latestComicPublished {
                    latestComicPublished = currentLast
                    UserDefaults.standard.set(latestComicPublished, forKey: "latestComicPublished")
                    await updateWithNewest()
                }
            }
            
            /// Loads the favorite comics if there are any
            if let favs = UserDefaults.standard.data(forKey: "favorites") {
                if let decoded = try? decoder.decode([Comic].self, from: favs) {
                    favorites = decoded
                } else {
                    print("Can't Decode")
                }
            }
            
            
        } else {
            print("No comics found")
            /// No comics are found in UserDefaults, so it fetches the latest 10.
            Task {
                latestComicPublished = await fetchLatest()
                UserDefaults.standard.set(latestComicPublished, forKey: "latestComicPublished")
                await fetchComics(amount: 10)
            }
        }
    }
    
    @MainActor func fetchComics(amount: Int) async {
        /// Fetches the required amount of comics and stores them both on the array and on the UserDefaults
        
        var fetchFrom: Int
        var urlComponents = URLComponents(string: "https://xkcd.com/")!
        
        /// Checks if it's the first time fetching comics
        if comics.isEmpty {
            fetchFrom = await fetchLatest()
        } else {
            fetchFrom = latestComicSaved!-1
        }
        
        print("Fetching \(amount) comics from \(fetchFrom)")
        
        for i in (fetchFrom-amount...fetchFrom).reversed() {
            urlComponents.path = "/\(i)/info.0.json"
            
            do {
                let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { print("Bad response: \(response)"); return}
                
                /// Comics are decoded and saved to to the array. It also stores the current comic as the last saved so that if the next doesn't gets trrough (bad response, low connectivity) it will resume from this next time
                if let comic = try? decoder.decode(Comic.self, from: data) {
                    comics.append(comic)
                    latestComicSaved = comic.num
                    UserDefaults.standard.set(latestComicSaved, forKey: "latestComicSaved")
                    print("Saved comic #\(comic.num)")
                    
                } else {
                    print("Can't Decode")
                }
            } catch {
                print(error)
            }
        }
        /// The updated array is stored on UserDefaults
        if let updatedComics = try? encoder.encode(comics) {
            UserDefaults.standard.set(updatedComics, forKey: "comics")
            print("Saved comics")
            print(comics.map { $0.num })
        } else {
            print("Cant Encode")
        }
    }
    
    @MainActor func fetchLatest() async -> Int {
        /// Returns the number of the latest comic published on the website
        let urlComponents = URLComponents(string: "https://xkcd.com/info.0.json")!
        
        do {
            let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { print("Bad response: \(response)"); return latestComicPublished }
            
            if let comic = try? decoder.decode(Comic.self, from: data) {
                
                print("Latest comic is: \(comic.num)")
                return comic.num
                
            } else {
                print("Can't Decode")
            }
            
        } catch {
            print("Error")
        }
        return latestComicPublished
    }
    
    @MainActor func updateWithNewest() async {
        /// Fetches the newest comics that have been added to the website.
        print("Updating with newest")
        
        var urlComponents = URLComponents(string: "https://xkcd.com/")!
        
        for (i, comicNum) in (comics[0].num...latestComicPublished).reversed().enumerated() {
            urlComponents.path = "/\(comicNum)/info.0.json"
            
            do {
                let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { print("Bad response: \(response)"); return}
                
                if let comic = try? decoder.decode(Comic.self, from: data) {
                    comics.insert(comic, at: i)
                    print("Saved comic #\(comic.num) at \(i)")
                    
                } else {
                    print("Can't Decode")
                }
            } catch {
                print(error)
            }
        }
        
        if let updatedComics = try? encoder.encode(comics) {
            UserDefaults.standard.set(updatedComics, forKey: "comics")
            print("Saved comics")
            print(comics.map { $0.num })
        } else {
            print("Cant Encode")
        }
    }
    
    func saveToFavorites(comic: Comic) {
        /// Saves a comic to the favorites and updates the stored data on UserDefaults
        favorites.append(comic)
        
        if let favs = try? encoder.encode(favorites) {
            UserDefaults.standard.set(favs, forKey: "favorites")
            print("Saved favorites")
            print(favorites.map { $0.num })
        } else {
            print("Cant Encode")
        }
    }
    
    func removeFromFavorites(comic: Comic) {
        /// Removes a comic from the favorites and updates the stored data on UserDefaults
        favorites.removeAll(where: {$0.num == comic.num})
        
        if let favs = try? encoder.encode(favorites) {
            UserDefaults.standard.set(favs, forKey: "favorites")
            print("Saved favorites")
            print(favorites.map { $0.num })
        } else {
            print("Cant Encode")
        }
    }
    
}


