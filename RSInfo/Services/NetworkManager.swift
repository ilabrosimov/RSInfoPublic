//
//  NetworkManager.swift
//  RSInfo
//
//  Created by ilabrosimov on 9/7/21.
//

import Foundation
import CryptoKit

class NetworkManager {
    private let urlLector = ""
    private let urlCourse = ""
    private let urlStudent = ""
    
    private let urlConfirmed = ""
    private let urlLogin = ""
    private let urlChangePass = ""
    static let shared = NetworkManager()
    private init () {}
    
    
    func APIAuthRequest (credentials: Credentials, completion: @escaping ((Bool) -> Void)) {
        let hashMd5 = MD5(string: credentials.pin)
        guard let url = URL(string: "\(urlLogin)\(credentials.coachId)&hash=\(hashMd5)") else {return}
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data,_, error) in
            guard let data = data else {return }
            do {
                let loginResponse = try JSONDecoder().decode(Login.self, from: data)
                completion (loginResponse.response)
            }
            catch {
                //print(error)
            }
        }.resume()
    }
    
    
    func fetchData <T: Codable> (id: String, completion: @escaping (([T]) -> Void)) {
        var urlString : String = ""
        
        if T.self is Lector.Type { urlString = urlLector }
        if T.self is Course.Type { urlString = urlCourse }
        if T.self is Student.Type { urlString = urlStudent }
        
        guard let url = URL(string: "\(urlString)\(id)") else {return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data,_, error) in
            if let error = error {
                print("Connection failed")
                print(error.localizedDescription)
                completion([T]())
            }
            
            guard let data = data else {return }
            do {
                let result = try JSONDecoder().decode([T].self, from: data)
                completion(result)
            }
            catch  {
                print("JsonDecoder failed")
                completion([T]())
            }
        }.resume()
    }
    
    
    
    func postRequest(studentId:String, confirmation: Bool)  {
        
        let value = (confirmation ? "1" : "0")
        guard let url = URL(string: urlConfirmed) else {return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "studentid", value: studentId),
            URLQueryItem(name: "isconfirmed", value: value)
        ]
        let query = components.url!.query
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query!.utf8)
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response,error in
            
            if let response = response {
                print(response)
            }
        }.resume()
    }
    func requestChangePass(pin: String, userId: String)  {
        
        let hash = MD5(string: pin)
        guard let url = URL(string: urlChangePass) else {return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "userid", value: userId)
        ]
        let query = components.url!.query
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query!.utf8)
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response,error in
            
            if let response = response {
                let httpUrlResponse = response as! HTTPURLResponse
                print(httpUrlResponse.statusCode)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                    print(json)
                } catch _ {
                    print("Wrong JSON resonse, Password is changed")
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }

    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
