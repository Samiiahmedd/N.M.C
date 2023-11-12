//
//  HomVC.swift
//  N.M.C
//  Created by Sami Ahmed on 08/11/2023.
//

import UIKit

class HomVC: UIViewController, UISearchBarDelegate {
    //MARK: - Variables
    var     Banners : [slide] = []
    var MedicalGroups : [Category] = []
    var latestContracts : [image] = []
    var medicalUpgrades : [Category] = []
    let loader = UIAlertController.loader()
    private let searchBar = UISearchBar()
    
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var MedicalGroupCollectionView: UICollectionView!
    @IBOutlet weak var latestContractsCollectionView: UICollectionView!
    @IBOutlet weak var medicalUpgradeCollectionView: UICollectionView!
    
    //MARK: - viewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let greetingLabel = UILabel()
        greetingLabel.text = "مرحبا"
        greetingLabel.textColor = UIColor(named: "Color 4")
        greetingLabel.font = UIFont(name: "Cairo-Bold", size: 24)
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let questionLabel = UILabel()
        questionLabel.text = "كيف حالك اليوم؟"
        questionLabel.textColor = UIColor.gray
        questionLabel.font = UIFont(name: "Cairo-Light", size: 16)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let customTextField = UITextField()
        customTextField.placeholder = "البحث"
        customTextField.layer.cornerRadius = 8
        customTextField.layer.masksToBounds = true
        customTextField.backgroundColor = UIColor.systemGray6
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let searchIconImageView = UIImageView()
        searchIconImageView.image = UIImage(systemName: "magnifyingglass")
        searchIconImageView.contentMode = .center
        searchIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconContainerView: UIView = UIView()
        iconContainerView.addSubview(searchIconImageView)
        customTextField.leftView = iconContainerView
        customTextField.leftViewMode = .always
        iconContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(named: "Filter"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        customTextField.rightView = searchButton
        customTextField.rightViewMode = .always
        
        // Add views to the hierarchy
        stackView.addSubview(greetingLabel)
        stackView.addSubview(questionLabel)
        stackView.addSubview(customTextField)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -10),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            questionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: -10),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            customTextField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 0),
            customTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            customTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            customTextField.heightAnchor.constraint(equalToConstant: 55),

            iconContainerView.widthAnchor.constraint(equalToConstant: 50),
            iconContainerView.heightAnchor.constraint(equalToConstant: 50),

            searchIconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            searchIconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),

            searchButton.widthAnchor.constraint(equalToConstant: 50),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        
        
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        MedicalGroupCollectionView.dataSource = self
        MedicalGroupCollectionView.delegate = self
        latestContractsCollectionView.dataSource = self
        latestContractsCollectionView.delegate = self
        medicalUpgradeCollectionView.dataSource = self
        medicalUpgradeCollectionView.delegate = self
        registerCells()
        loader.startLoader()
        
        //        let customTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        //        customTextField.placeholder = "البحث"
        //        customTextField.layer.cornerRadius = 8
        //        customTextField.layer.masksToBounds = true
        //        customTextField.backgroundColor = UIColor.systemGray6
        //
        //        let searchIconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        //        searchIconImageView.image = UIImage(systemName: "magnifyingglass")
        //        searchIconImageView.contentMode = .center
        //
        //        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        //        iconContainerView.addSubview(searchIconImageView)
        //        customTextField.leftView = iconContainerView
        //        customTextField.leftViewMode = .always
        //
        //        let searchButton = UIButton(type: .system)
        //        searchButton.setImage(UIImage(named: "Filter"), for: .normal)
        //        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        //        searchButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        //        customTextField.rightView = searchButton
        //        customTextField.rightViewMode = .always
        //        navigationItem.titleView = customTextField
        //
        
        //SliderAPI
        HomeViewModel().getSliderApi { result in
            //            self.stopLoader(loader: loader)
            switch result {
            case .success(let data):
                self.Banners = data.data
                DispatchQueue.main.async {
                    self.bannerCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //MedicalGroupAPI
        HomeViewModel().getMedicalGroupApi { result in
            //            self.stopLoader(loader: loader)
            switch result {
            case .success(let data):
                self.MedicalGroups = data.data
                DispatchQueue.main.async {
                    self.MedicalGroupCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //getMedicalUpgradeAPI
        HomeViewModel().getMedicalUpgradeAPI { [weak self] result in
            DispatchQueue.main.async {
                self?.loader.stopLoader()
                switch result {
                case .success(let data):
                    self?.medicalUpgrades = data.data
                    self?.medicalUpgradeCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        //latestEnagements
        HomeViewModel().getlatestEnagementsApi { result in
            //            self.stopLoader(loader: loader)
            switch result {
            case .success(let data):
                self.latestContracts = data.data
                DispatchQueue.main.async {
                    self.latestContractsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    @objc private func searchButtonTapped() {
        let searchViewController = SearchVC()
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            print("Searching for: \(searchText)")
        }
    }
    
    
    
    //MARK: - functions
    private func registerCells() {
        bannerCollectionView.register(UINib(nibName: BannerCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifer)
        MedicalGroupCollectionView.register(UINib(nibName: MedicalGroupCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: MedicalGroupCollectionViewCell.identifer)
        latestContractsCollectionView.register(UINib(nibName: latestContractsCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: latestContractsCollectionViewCell.identifer)
        medicalUpgradeCollectionView.register(UINib(nibName: MedicalGroupCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: MedicalGroupCollectionViewCell.identifer)
    }
}

extension HomVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannerCollectionView:
            return Banners.count
        case MedicalGroupCollectionView:
            return MedicalGroups.count
        case latestContractsCollectionView:
            return latestContracts.count
        case medicalUpgradeCollectionView:
            return medicalUpgrades.count
        default: return 0
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            
        case bannerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifer, for: indexPath) as! BannerCollectionViewCell
            cell.setup(Banner: Banners[indexPath.row])
            return cell
            
        case MedicalGroupCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicalGroupCollectionViewCell.identifer, for: indexPath) as! MedicalGroupCollectionViewCell
            cell.setup(MedicalGroup: MedicalGroups[indexPath.row])
            return cell
            
        case latestContractsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: latestContractsCollectionViewCell.identifer, for: indexPath) as! latestContractsCollectionViewCell
            cell.setup(latestContracts: latestContracts[indexPath.row])
            return cell
            
        case medicalUpgradeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicalGroupCollectionViewCell.identifer, for: indexPath) as! MedicalGroupCollectionViewCell
            cell.setup(MedicalGroup: medicalUpgrades[indexPath.row])
            return cell
            
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannerCollectionView:
            
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        case MedicalGroupCollectionView:
            return CGSize(width: 104, height: 100)
        case latestContractsCollectionView:
            return CGSize(width: 100, height: 100)
        case medicalUpgradeCollectionView:
            return CGSize(width: 104, height: 100)
        default:
            return CGSize(width: 100, height: 100)
        }
        
    }
}
