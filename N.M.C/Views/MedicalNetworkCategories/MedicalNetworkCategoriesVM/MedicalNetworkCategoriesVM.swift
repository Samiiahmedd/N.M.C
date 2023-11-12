//
//  MedicalNetworkCategoriesVM.swift
//  N.M.C
//
//  Created by Sami Ahmed on 26/11/2023.
//

import Foundation
class MedicalNetworkCategoriesVM{
    static let shared = MedicalNetworkCategoriesVM()
    
    //Get category
    @MainActor
    func getMedicalByCategory(path: String, completion:@escaping (Result <MedicalGroupAllModel, Error>) -> Void) {
        guard let encodedCategory = path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        guard let url = URL(string: "https://api.nmc.com.eg/public/api/getMedicalNetworkByCategory/\(encodedCategory)") else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(APIError.failedTogetData))
                return
            }
            do{
                let results = try JSONDecoder().decode(MedicalGroupAllModel.self, from: data)
                print(data)
                completion(.success(results))
            }catch{
                print(error.localizedDescription)
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}
