//
//  API.swift
//  PrefectureFortuneTelling
//
//  Created by 若生優希 on 2024/08/05.
//

import Foundation

class API {
    let baseURL = "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud"
    let endpoint = "/my_fortune"
    
    func fetchPrefecture(request: HTTPBody) {
        let url = URL(string: baseURL + endpoint)!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("v1", forHTTPHeaderField: "API-Version")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(request)
        } catch {
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            if let error {
                return
            }
            guard let data else{
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseBody = try decoder.decode(HTTPBody.self, from: data)
            } catch {
                return
            }
        }
        
        task.resume()
    }
}
