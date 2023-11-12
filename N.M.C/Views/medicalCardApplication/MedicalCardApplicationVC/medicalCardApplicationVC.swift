//
//  medicalCardApplicationVC.swift
//  N.M.C
//
//  Created by Sami Ahmed on 13/11/2023.
//

import UIKit

//Protocol
protocol selectedPaymentMethod: AnyObject {
    func didSelectPaymentMethod(_ paymentData: PaymnetMethod)
}

enum CurrentMedicaCardlPage {
    case personalData, additionalData
}

class medicalCardApplicationVC: UIViewController {
    
    // MARK: - Variables
    private var vm = MedicalCardApplicationPayementViewModel.shared
    private var currentPage: CurrentMedicaCardlPage = .personalData
    private var selectedPaymentMethod: PaymnetMethod?
    
    // MARK: - IBOutlet
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    @IBOutlet weak var personalInfoStack: UIStackView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var nationalID: UITextField!
    @IBOutlet weak var uploadPhoto: UIButton!
    @IBOutlet weak var additionalInfoStack: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButtonn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var workPlace: UITextField!
    @IBOutlet weak var houseNumber: UITextField!
    @IBOutlet weak var job: UITextField!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        if let customFont = UIFont(name: "Cairo-Regular", size: 18) {
            let titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                NSAttributedString.Key.font: customFont
            ]
            segmentOutlet.setTitleTextAttributes(titleTextAttributes, for: .normal)
        }
    }
    
    // MARK: - IBActions
    @IBAction func nextButton(_ sender: Any) {
        switch currentPage {
        case .personalData:
            if validateFields(){
                currentPage = .additionalData
                updateUI()
            }
        case .additionalData:
            if validateSecondFields(){
                
                let paymentMethodPicker = MedicalCardApplicationPaymentVC()
                paymentMethodPicker.delegate = self
                paymentMethodPicker.modalPresentationStyle = .overFullScreen
                paymentMethodPicker.modalTransitionStyle = .crossDissolve
                self.present(paymentMethodPicker, animated: true)
            }
            
            
            //            vm.uploadImage(full_name: fullName.text ?? "",
            //                           address: address.text ?? "",
            //                           date_of_birth: birthDate.text ?? "",
            //                           national_id: nationalID.text ?? "",
            //                           phone_number: houseNumber.text ?? "",
            //                           numberOfYears: "1",
            //                           job: job.text ?? "",
            //                           card_type: "للفرد",
            //                           photo: (imageView.image ?? UIImage(systemName: "person.circle.fill"))!)
            //
            //            let MedicalCardApplicationPaymentVC = MedicalCardApplicationPaymentVC()
            //            self.navigationController?.pushViewController(MedicalCardApplicationPaymentVC, animated: true)
            //
        }
    }
    
    @IBAction func uploadPhotoButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    //MARK: - Functions
    private func validateFields() -> Bool {
        if fullName.text?.isEmpty ?? true ||
            address.text?.isEmpty ?? true ||
            birthDate.text?.isEmpty ?? true ||
            nationalID.text?.isEmpty ?? true {
            displayValidationAlert(message: "Please fill all fields")
            return false
        }
        
        let nationalId = nationalID.text!
        let digitRegex = #"^\d{14}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", digitRegex)
        if !predicate.evaluate(with: nationalId) {
            displayValidationAlert(message: "National ID must be 14 numeric digits")
            return false
        }
        return true
    }
    
    private func validateSecondFields() ->Bool {
        if email.text?.isEmpty ?? true ||
            companyName.text?.isEmpty ?? true ||
            workPlace.text?.isEmpty ?? true ||
            houseNumber.text?.isEmpty ?? true ||
            job.text?.isEmpty ?? true {
            displayValidationAlert(message: "Please fill all fields")
            return false
        }
        return true
    }
    
    private func updateUI() {
        switch currentPage {
        case .personalData:
            nextButtonn.setTitle("التالي", for: .normal)
            additionalInfoStack.isHidden = true
        case .additionalData:
            nextButtonn.setTitle("تقديم", for: .normal)
            personalInfoStack.isHidden = true
            additionalInfoStack.isHidden = false
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

//MARK: - Extentions
extension  medicalCardApplicationVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
}

extension medicalCardApplicationVC: selectedPaymentMethod {
    func didSelectPaymentMethod(_ paymentData: PaymnetMethod) {
        selectedPaymentMethod = paymentData
        
        let body = [
            "first_name": fullName.text ?? "",
            "last_name": fullName.text ?? "",
            "email": email.text ?? "",
            "phone": houseNumber.text ?? "",
            "address": address.text ?? "",
            "card_type": "للفرد",
            "price": 300,
            "payment_method_id": 4,
            "cartTotal": 300
        ] as [String : Any]
        
        vm.executePayment(body: body) { result in
            switch result {
            case .success(let responseData):
                print("Payment succeeded. Response data: \(responseData)")
            case .failure(let error):
                print("Payment failed with error: \(error.localizedDescription)")
            }
        }
    }
}






