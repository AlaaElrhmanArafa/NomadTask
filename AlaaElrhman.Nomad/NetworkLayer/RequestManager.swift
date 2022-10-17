//
//  RequestManager.swift
//  AlaaElrhman.Nomad
//
//  Created by AlaaElrhman on 15/10/2022.
//

import Foundation

class RequestManager {
    
    static let defaultManager = RequestManager()
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func WebServiceApiRequest<T: Codable>(service: Endpoints ,parameters: String?, complete: @escaping (T?,_ error:APIError?)->() ) {
        let urlString = service.url
        print(urlString)
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        let session = URLSession.shared
        var request = URLRequest(url: url!)
    
        request.httpMethod = service.httpMethod.rawValue
        if let postString = parameters {
            request.httpBody = postString.data(using: .utf8)
        }

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                if error?._code == NSURLErrorTimedOut{
                    complete(nil,.timeOut)
                    return
                }
                switch (response as? HTTPURLResponse)?.statusCode{
                case 401:
                    complete(nil,.notAuthorized)
                case 500:
                    complete(nil,.internalServerError)
                case 404:
                    complete(nil,.notFound)
                default:
                    complete(nil,.unknown)
                }
                return
            }
            do{
                let json = try JSONDecoder().decode(T.self, from: data)
                print(json)
                complete(json, .none)
                return
            }catch let decodingerror{
                print(decodingerror)
                complete(nil,.decodingError)
                return
            }
            
            
        })
        task.resume()
    }
    
}
