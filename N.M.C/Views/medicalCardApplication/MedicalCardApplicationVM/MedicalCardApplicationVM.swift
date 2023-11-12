import Foundation
import UIKit

class MedicalCardApplicationVM {
    static let shared = MedicalCardApplicationVM()

    private init() {}
    
    func uploadImage(full_name: String,
                     address: String,
                     date_of_birth: String,
                     national_id: String,
                     phone_number: String,
                     numberOfYears: String,
                     job: String,
                     card_type: String,
                     photo: UIImage, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let url = URL(string: "https://api.nmc.com.eg/public/api/bookings")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var body = Data()
        
        if let photoData = photo.pngData() {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.png\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            body.append(photoData)
            body.append("\r\n".data(using: .utf8)!)
        } else {
            print("errorrrr")
        }
        
        for (key, value) in [
            "invoices_key": "1234",
            "full_name": full_name,
            "address": address,
            "date_of_birth": date_of_birth,
            "national_id": national_id,
            "phone_number": phone_number,
            "numberOfYears": numberOfYears,
            "job": job,
            "card_type": card_type
        ] {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(APIError.faildToUpload))
                return
            }
            completion(.success(true))
        }
        
        task.resume()
    }
    
    
 
    
    private func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
}
