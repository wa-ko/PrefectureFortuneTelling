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
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "POST"
        urlRequest.setValue("v1", forHTTPHeaderField: "API-Version")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(request)
            urlRequest.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let data else {
                print("No data received")
                return
            }
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
