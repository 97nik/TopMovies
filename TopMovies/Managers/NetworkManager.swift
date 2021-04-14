//
//  NetworkManager.swift
//  TopMovies
//
//  Created by Никита on 13.04.2021.
//

import Foundation
import UIKit

enum ApiError : Error {
    case noData
}
var alert = TableViewController()

class NetworkManager {
    
    enum RequestType {
        case topOld
        case topToday
    }
    
    var onResult: ((Result<SearchResponse, Error>) -> Void)?
    
    func fetchMovie (forRequestType requestType: RequestType) {
        
        let apiKey = "1d5bdcccb0accd66a14c74a8b1b1432d"
        var urlString = ""
        switch requestType {
        case .topOld:
            urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=ru-RU&year=2019"
        case .topToday:
            urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=ru-RU"
        }
        performRequest(withURLString: urlString)
    }
    
    
    func performRequest(withURLString urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if CheckWiFi.isConnectedToNetwork(){
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if httpResponse.statusCode == 404 {
                        self.onResult?(.failure(ApiError.noData))
                        return
                    } else if httpResponse.statusCode != 200 {
                        self.onResult?(.failure(ApiError.noData))
                        return
                    }
                }
                
                if let data = data {
                    
                    let decoder = JSONDecoder()
                    do {
                        let objects = try decoder.decode(SearchResponse.self, from: data)
                        self.onResult?(.success(objects))
                    } catch let error as NSError {
                        self.onResult?(.failure(error))
                        print(error.localizedDescription)
                    }
                }else {
                    self.onResult?(.failure(ApiError.noData))
                    print(ApiError.noData)
                    return
                }
            } else{
                print("Internet Connection not Available!")
                self.onResult?(.failure(ApiError.noData))
                return
            }
        }
        task.resume()
    }
}

