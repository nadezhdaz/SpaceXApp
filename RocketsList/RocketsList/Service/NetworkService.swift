//
//  NetworkService.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 13.09.2021.
//

import Foundation

enum NetworkError: Error {
    case notFound
    case badRequest
    case notAcceptable
}

class NetworkService {
    
    //
    // MARK: - Constants
    //
    
    public static let shared = NetworkService()
    
    let defaultSession = URLSession(configuration: .default)
    let defaultAPIstringURL = "https://api.spacexdata.com/v4/rockets"
    let scheme = "https"
    let host = "api.spacexdata.com"
    let rocketsPath = "/v4/rockets"
    let launchesPath = "/v5/launches"
    let launchpadsPath = "/v4/launchpads"
   
    let jsonHeaders = [
        "Content-Type" : "application/json"
    ]
    
    // MARK: - Type Alias
    //
    public typealias JSONDictionary = [String: Any]
    
    public typealias Rockets = [Rocket]
    public typealias Launches = [Launch]
    public typealias Launchpads = [Launchpad]
    
    public typealias RocketsResult = ([Rocket]?, Error?) -> Void
    public typealias LaunchesResult = ([Launch]?, Error?) -> Void
    public typealias LaunchpadsResult = ([Launchpad]?, Error?) -> Void
    
    //
    // MARK: - Public Methods
    //
    
    func getLaunchpadsFeedRequest(completion: @escaping LaunchpadsResult) {
        guard let request = urlRequestWith(path: launchpadsPath) else { return }
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                completion(nil, error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) {
                guard let launchpads = self.parseLaunchpadsData(data) else { return }
                completion(launchpads, nil)
            }
        }
        
        task.resume()
    }
    
    func getLaunchpadRequest(id: String, completion: @escaping (Launchpad?, Error?) -> Void) {
        let id = id
        let path = launchpadsPath + "/\(id)"
        
        guard let request = urlRequestWith(path: path) else { return }
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                completion(nil, error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) {
                guard let launchpad = self.parseLaunchpadData(data) else { return }
                completion(launchpad, nil)
            }
            
        }
        
        task.resume()
    }
    
    func getLaunchesFeedRequest(completion: @escaping LaunchesResult) {
        guard let request = urlRequestWith(path: launchesPath) else { return }
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                completion(nil, error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) {
                guard let launches = self.parseLaunchesData(data) else { return }
                completion(launches, nil)
            }
        }
        
        task.resume()
    }
    
    func getLaunchRequest(id: String, completion: @escaping (Launch?, Error?) -> Void) {
        let id = id
        let path = launchesPath + "/\(id)"
        
        guard let request = urlRequestWith(path: path) else { return }
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                completion(nil, error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) {
                guard let launch = self.parseLaunchData(data) else { return }
                completion(launch, nil)
            }
            
        }
        
        task.resume()
    }
    
    func getRocketsFeedRequest(completion: @escaping RocketsResult) {
        guard let request = urlRequestWith(path: rocketsPath) else { return }
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                completion(nil, error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) {
                guard let rockets = self.parseRocketsData(data) else { return }
                completion(rockets, nil)
            }
        }
        
        task.resume()
    }
    
    func getRocketRequest(id: String, completion: @escaping (Rocket?, Error?) -> Void) {
        let id = id
        let path = rocketsPath + "/\(id)"
        
        guard let request = urlRequestWith(path: path) else { return }
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                completion(nil, error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) {
                guard let rocket = self.parseRocketData(data) else { return }
                completion(rocket, nil)
            }
            
        }
        
        task.resume()
    }

    
    //
    // MARK: - Private Methods
    //
    
    public func urlRequestWith(path: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accepts")
        
        return request
    }
    
    private func parseLaunchpadData(_ data: Data) -> Launchpad? {
        do {
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let launchpad = try decoder.decode(Launchpad.self, from: data)
            return launchpad
          } catch {
            debugPrint(error)
            print("JSONDecoder error: \(error.localizedDescription)\n")
            return nil
        }
    }
    
    private func parseLaunchpadsData(_ data: Data) -> [Launchpad]? {
        do {
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let launchpads = try decoder.decode([Launchpad].self, from: data)
            return launchpads
          } catch {
            debugPrint(error)
            print("JSONDecoder error: \(error.localizedDescription)\n")
            return nil
        }
    }
    
    private func parseLaunchData(_ data: Data) -> Launch? {
        do {
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let launch = try decoder.decode(Launch.self, from: data)
            return launch
          } catch {
            debugPrint(error)
            print("JSONDecoder error: \(error.localizedDescription)\n")
            return nil
        }
    }
    
    private func parseLaunchesData(_ data: Data) -> [Launch]? {
        do {
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let launches = try decoder.decode([Launch].self, from: data)
            return launches
          } catch {
            debugPrint(error)
            print("JSONDecoder error: \(error.localizedDescription)\n")
            return nil
        }
    }
    
    private func parseRocketData(_ data: Data) -> Rocket? {
        do {
            let decoder = JSONDecoder()
            let rocket = try decoder.decode(Rocket.self, from: data)
            return rocket
          } catch {
            debugPrint(error)
            print("JSONDecoder error: \(error.localizedDescription)\n")
            return nil
        }
    }
    
    private func parseRocketsData(_ data: Data) -> [Rocket]? {
        do {
            let decoder = JSONDecoder()
            let rockets = try decoder.decode([Rocket].self, from: data)
            return rockets
          } catch {
            debugPrint(error)
            print("JSONDecoder error: \(error.localizedDescription)\n")
            return nil
        }
    }
}
