//
//  MyWalletViewController.swift
//  trings
//
//  Created by Alex Cornforth on 27/10/2022.
//

import UIKit

class MyWalletViewController: UIViewController, AlertPresenting {

    @IBOutlet private weak var treeCountLabel: UILabel!
    @IBOutlet private weak var treeCollectionView: UICollectionView!
    @IBOutlet private weak var walletCreatedLabel: UILabel!
    @IBOutlet private weak var profileNameLabel: UILabel!
    @IBOutlet private weak var bannerView: UIView!
    @IBOutlet private weak var tokenCountLabel: UILabel!
    @IBOutlet private weak var treesCountView: UIView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showTreeMapView))
            treesCountView.addGestureRecognizer(tapGesture)
            treesCountView.isUserInteractionEnabled = true
            treesCountView.layer.cornerRadius = 20
            treesCountView.backgroundColor = Asset.Colors.primaryGreen.color
            treesCountView.layer.opacity = 0.6
        }
    }
    @IBOutlet private weak var tokensCountView: UIView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(purchaseTokens))
            tokensCountView.addGestureRecognizer(tapGesture)
            tokensCountView.isUserInteractionEnabled = true
            tokensCountView.layer.cornerRadius = 20
            tokensCountView.backgroundColor = Asset.Colors.secondaryOrangeLight.color
            tokensCountView.layer.opacity = 0.6
        }
    }
    var viewModel: MyWalletViewModel? {
        didSet {
            title = viewModel?.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let banner = WalletBannerView(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 30, height: 200))
        bannerView.addSubview(banner)
        banner.bannerImageView.image = UIImage(named: "banner")
        banner.profileImageView.image = UIImage(named: "profile")
        bannerView.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 225))
        profileNameLabel.text = "dadiorchen"
        walletCreatedLabel.text = "Wallet created on October 07, 2021"
        treeCollectionView.dataSource = viewModel
        treeCollectionView.delegate = self
        treeCountLabel.text = "170"
        tokenCountLabel.text = "170"
    }
}

// MARK: - Button Actions
extension MyWalletViewController {
    @IBAction private func logoutButtonPressed() {
        viewModel?.logout()
    }
    @objc func showTreeMapView() {
        viewModel?.showTreeMapView()
    }
    @objc func purchaseTokens() {
        viewModel?.showPurchaseView()
    }
}

// MARK: - MyWalletViewModelViewDelegate
extension MyWalletViewController: MyWalletViewModelViewDelegate {
    func myWalletViewModel(_ myWalletViewModel: MyWalletViewModel, didReceiveError error: Error) {
        present(alert: .error(error))
    }
}
extension MyWalletViewController: UICollectionViewDelegate {

}
