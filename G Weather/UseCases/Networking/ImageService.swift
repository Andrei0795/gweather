//
//  ImageService.swift
//  G Weather
//
//  Created by Andrei Ionescu on 10.08.2024.
//

import Alamofire
import AlamofireImage
import Foundation
import UIKit

class ImageService {
    
    static let shared = ImageService()
    
    private init() {}
    
    func fetchImage(from urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseImage { response in
                switch response.result {
                case .success(let image):
                    continuation.resume(returning: image)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
