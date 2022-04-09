//
//  RoboCatViewModel.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-04-09.
//

import Foundation
import UIKit

struct APIResponse: Codable{
    let total: Int
    let total_pages: Int
    let results: [Images]
}

struct Images: Codable{
    let id: String
    let urls: URLS
}

struct URLS: Codable{
    let full: String
}
class RoboCatViewModel: ObservableObject{
    let urlString = "https://api.unsplash.com/search/photos?page=1&query=office&client_id=xY8LDKUKTqdbLXLoYlQ1w0mmzMWsr9wWIitg5hIr-vE"
    
    func fetchPhotos(){
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let jsonObj = try JSONDecoder().decode(APIResponse.self, from: data)
                print(jsonObj.results.count)
            }
            catch{
                print(error)
            }
            print("data fetched")
        }
        task.resume()
        
    }
}
