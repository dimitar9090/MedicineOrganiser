import Foundation

class OpenFDAService {
    func fetchDrugInformation(query: String, completion: @escaping (Result<DrugResponse, Error>) -> Void) {
        let queryString = query.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.fda.gov/drug/label.json?search=\(queryString)&limit=10"
        print("URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            print("Raw JSON Response: ", String(data: data, encoding: .utf8) ?? "No readable data")

            do {
                let drugResponse = try JSONDecoder().decode(DrugResponse.self, from: data)
                completion(.success(drugResponse))
            } catch {
                print("Decoding error: \(error)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, let context):
                        print("Key '\(key)' not found:", context.debugDescription)
                    case .valueNotFound(let value, let context):
                        print("Value '\(value)' not found:", context.debugDescription)
                    case .typeMismatch(let type, let context):
                        print("Type '\(type)' mismatch:", context.debugDescription)
                    case .dataCorrupted(let context):
                        print("Data corrupted:", context.debugDescription)
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
