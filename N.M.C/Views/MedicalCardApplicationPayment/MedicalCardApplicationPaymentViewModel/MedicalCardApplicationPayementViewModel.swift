//
//  MedicalCardApplicationPayementViewModel.swift
//  N.M.C
//
//  Created by Sami Ahmed on 27/11/2023.
//

import Foundation
class MedicalCardApplicationPayementViewModel {
    var responseHandler: ((_ result: Result<paymentData, Error>) -> Void)?
    static let shared = MedicalCardApplicationPayementViewModel()
    
    //Payment Api
    func getPayment(completion:@escaping (Result <PaymentModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)api/paymentMethods") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
            do{
                let results = try JSONDecoder().decode(PaymentModel.self, from: data)
                completion(.success(results))
            }catch{
                print(error.localizedDescription)
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    //excutePayment Api
    func executePayment(body: [String: Any], completion: @escaping (Result<ExcutePaymentModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)api/executePayment") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            guard let data = data else {return}
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
            do {
                let data = try JSONDecoder().decode(ExcutePaymentModel.self,from: data)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
