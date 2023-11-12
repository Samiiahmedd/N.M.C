//
//  MedicalCardApplicationPaymentCollectionViewCell.swift
//  N.M.C
//
//  Created by Sami Ahmed on 27/11/2023.
//

import UIKit
import Kingfisher

class MedicalCardApplicationPaymentCollectionViewCell: UICollectionViewCell {
    static let identifer =  String(describing: MedicalCardApplicationPaymentCollectionViewCell.self)

    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var title: UILabel!
    func setup(PayData: PaymnetMethod){
        Logo.kf.setImage(with: PayData.logo.asUrl)
        title.text = PayData.name_ar
    }
}
