//
//  Constants.swift
//  N.M.C
//
//  Created by Sami Ahmed on 26/11/2023.
//

import Foundation
struct Constants {
    static let baseURL = "https://api.nmc.com.eg/public/"
}

enum APIError : Error {
    case failedTogetData
    case faildToUpload
    case invalidUrl
}
