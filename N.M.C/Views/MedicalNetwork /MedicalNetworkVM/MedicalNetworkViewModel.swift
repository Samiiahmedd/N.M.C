//
//  MedicalNetworkViewModel.swift
//  N.M.C
//
//  Created by Sami Ahmed on 26/11/2023.
//

import Foundation

class MedicalNetworkViewModel{
    static let shared = MedicalNetworkViewModel()

    //medicalNetworkDetails
    @MainActor
    func  medicalNetworkDetails(completion:@escaping (Result <MedicalGroupAllModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)api/getCategoryProductCounts") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(MedicalGroupAllModel.self, from: data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }  
}
