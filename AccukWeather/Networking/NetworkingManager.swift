import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case noData
}

protocol Networking {
    func fetchData<T: Codable>(from urlString: String,
                               httpMethod: String,
                               completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkingManager: Networking {
    static let shared = NetworkingManager()
    
    func fetchData<T: Codable>(from urlString: String,
                               httpMethod: String,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.invalidResponse))
            }
        }.resume()
    }
}
