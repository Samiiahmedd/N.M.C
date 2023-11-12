//
//  Model.swift
//  N.M.C
//
//  Created by Sami Ahmed on 27/11/2023.
//

import Foundation

struct PaymentModel : Codable {
    let data: paymentData
}

struct paymentData:Codable {
    let data: [PaymnetMethod]
}

struct PaymnetMethod: Codable {
    let paymentId: Int
    let name_en: String
    let name_ar: String
    let redirect: String
    let logo: String
}





