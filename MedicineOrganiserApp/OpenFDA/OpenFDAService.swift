import Foundation

class OpenFDAService {
    func fetchDrugInformation(query: String, completion: @escaping (Result<DrugResponse, Error>) -> Void) {
        // URL encoding
        let queryString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.fda.gov/drug/label.json?search=brand_name:\(queryString)"
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
            
            do {
                let drugResponse = try JSONDecoder().decode(DrugResponse.self, from: data)
                completion(.success(drugResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
