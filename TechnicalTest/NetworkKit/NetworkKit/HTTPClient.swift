import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

open class HTTPClient<T: Codable> {

    public typealias completion = (_ object: T?) -> ()
    public typealias error = (_ message: String) -> ()
    private let defaults = UserDefaults.standard

    public init() {}

    public func request(url: String,
                 method: HTTPMethod = .get,
                 params: [String: Any] = [:],
                 _ completion: @escaping completion,
                 _ error: @escaping error) {

        guard
            let urlComponent = URLComponents(string: url),
            let url = urlComponent.url else {
                return error(Constants.invalidUrl)
        }

        var request = URLRequest(url: url)
        if method == .post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        request.httpMethod = method.rawValue
        
        var dataTask: URLSessionDataTask?
        let defaultSession = URLSession(configuration: .default)
        
        dataTask = defaultSession.dataTask(with: request) { data, response, err in
            
            defer {
                dataTask = nil
            }
            guard let data = data, err == nil else {
                return error(err?.localizedDescription ?? Constants.unknownError)
            }
            guard let model = self.parseModel(with: data) else {
                return error(Constants.jsonParseError)
            }
            completion(model)
        }
        dataTask?.resume()
    }

    private func parseModel(with data: Data) -> T? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject as Any, options: .prettyPrinted)
            let model = try JSONDecoder().decode(T.self, from: jsonData)
            return model
        } catch {
            return nil
        }
    }

}
