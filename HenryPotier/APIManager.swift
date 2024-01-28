//
//  APIManager.swift
//  HenryPotier
//
//  Created by Wassim on 26/01/2024.
//

import Foundation

class APIManager: BooksServices {
    
    func fetchBook(completion: @escaping (Result<Books, CustomError>) -> Void) {
        
        guard let url = URL(string: "http://henri-potier.xebia.fr/books") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataNotFound))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.wrongResponse))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let books = try JSONDecoder().decode(Books.self, from: data)
                    completion(.success(books))
                } catch {
                    completion(.failure(.jsonDecodingError(error.localizedDescription)))
                }
            }
        }.resume()
    }
}
