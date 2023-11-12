//
//  ExcutePaymentModel.swift
//  N.M.C
//
//  Created by Sami Ahmed on 28/11/2023.
//

import Foundation

struct ExcutePaymentModel: Codable {
    let data: PaymentData
}

struct PaymentData: Codable {
    let data: InvoiceData
}

struct InvoiceData: Codable {
    let invoice_id: Int
    let invoice_key: String
    let payment_data: PaymentDetails
}

struct PaymentDetails: Codable {
    let meezaReference: Int
    let meezaQrCode: String
}
