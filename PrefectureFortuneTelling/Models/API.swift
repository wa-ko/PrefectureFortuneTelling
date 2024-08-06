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
    
    func fetchFortune(request: FortuneRequest, completion: @escaping (Result<FortuneResponse, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("v1", forHTTPHeaderField: "API-Version")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(request)
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let data else { return }
            let decoder = JSONDecoder()
            do {
                let fortuneResponse = try decoder.decode(FortuneResponse.self, from: data)
                completion(.success(fortuneResponse))
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        task.resume()
    }
}
