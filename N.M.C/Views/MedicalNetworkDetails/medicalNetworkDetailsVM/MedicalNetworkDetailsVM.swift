//
//  MedicalNetworkDetailsVM.swift
//  N.M.C
//
//  Created by Sami Ahmed on 26/11/2023.
//

import Foundation
class MedicalNetworkDetailsVM{
    static let shared = MedicalNetworkDetailsVM()
    //API MedicalNetworkCategory Details
    @MainActor
    func  medicalNetworkCategoryDetails(id: Int, completion:@escaping (Result <medicalNetworkDetailsModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)api/getItemMedicalNetwork/\(id)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
            do{
                let results = try JSONDecoder().decode(medicalNetworkDetailsModel.self, from: data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
