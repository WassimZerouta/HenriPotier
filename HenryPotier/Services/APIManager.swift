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
    
    
    func fetchOffers(total: Int, completion: @escaping (Result<Int, CustomError>) -> Void) {
        
        guard let url = URL(string: "http://henri-potier.xebia.fr/books/\(CartManager.shared.isbnConcat())/commercialOffers") else {
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
                    let offers = try JSONDecoder().decode(Offers.self, from: data)
                    
                    var bestOffer: Int = total

                    for offer in offers {
                        switch offer.type {
                        case "percentage":
                            let reduction = total * offer.value / 100
                            let discountedTotal = total - reduction
                            if discountedTotal < bestOffer {
                                bestOffer = discountedTotal
                            }
                        case "minus":
                            let discountedTotal = total - offer.value
                            if discountedTotal < bestOffer {
                                bestOffer = discountedTotal
                            }
                        case "slice":
                            let slices = total / (offer.sliceValue ?? 1)
                            let reduction = slices * offer.value
                            let discountedTotal = total - reduction
                            if discountedTotal < bestOffer {
                                bestOffer = discountedTotal
                            }
                        default:
                            bestOffer = total
                        }
                    }

                    completion(.success(bestOffer))
                } catch {
                    completion(.failure(.jsonDecodingError(error.localizedDescription)))
                }
            }
        }.resume()
    }
}
