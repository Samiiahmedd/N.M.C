//
//  loader.swift
//  N.M.C
//
//  Created by Sami Ahmed on 19/11/2023.
//

import UIKit
extension UIViewController {
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "please wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        self.parent?.present(alert, animated: true,completion: nil)
        return alert
    }
    func stopLoader(loader:UIAlertController)  {
        DispatchQueue.main.async {
            loader.dismiss(animated:true, completion: nil)
        }
    }
}

extension UIAlertController {
    static func loader() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        return alert
    }

    func startLoader() {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(self, animated: true, completion: nil)
        }
    }

    func stopLoader() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
