//
//  HomeViewModel.swift
//  N.M.C
//
//  Created by Sami Ahmed on 26/11/2023.
//

import Foundation

class HomeViewModel {
static let shared = HomeViewModel()

    //HomeSliderAPI
    @MainActor
    func getSliderApi(completion:@escaping (Result <bannerModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)api/slider") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(bannerModel.self, from: data)
                print(data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    //HomeMedicalGroupAPI
    @MainActor
    func getMedicalGroupApi(completion:@escaping (Result <MedicalGroupModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)api/category") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(MedicalGroupModel.self, from: data)
                print(data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    //lastEngagements
    @MainActor
    func  getlatestEnagementsApi(completion:@escaping (Result <latestContractsModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)api/lastEngagements") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(latestContractsModel.self, from: data)
                print(data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    //HomeMedicalUpgradeAPI
    @MainActor
    func getMedicalUpgradeAPI (completion:@escaping (Result <MedicalGroupModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)api/lastCategory") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(MedicalGroupModel.self, from: data)
                print(data)
                completion(.success(results))
            }catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
}
