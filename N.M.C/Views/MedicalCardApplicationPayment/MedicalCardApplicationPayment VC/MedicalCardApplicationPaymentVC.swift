import UIKit

class MedicalCardApplicationPaymentVC: UIViewController {
    // MARK: - Variables
    private var vm = MedicalCardApplicationPayementViewModel.shared
    var Payment: [PaymnetMethod] = []
    var delegate: selectedPaymentMethod!
    
    // MARK: - IBoutlet
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        // API
        MedicalCardApplicationPayementViewModel().getPayment { result in
            switch result {
            case .success(let data):
                print(data)
                self.Payment = data.data.data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: MedicalCardApplicationPaymentCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: MedicalCardApplicationPaymentCollectionViewCell.identifer)
    }
}

extension MedicalCardApplicationPaymentVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Payment.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicalCardApplicationPaymentCollectionViewCell.identifer, for: indexPath) as! MedicalCardApplicationPaymentCollectionViewCell
        cell.setup(PayData: Payment[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let paymentMethod = Payment[indexPath.row]
        delegate.didSelectPaymentMethod(paymentMethod)
        dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 500, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
