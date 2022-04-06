//
//  CollectionController.swift
//  Music
//
//  Created by Sann Chhailong on 12/3/22.
//

import UIKit

open class CollectionController<T: CollectionCell<U>,U>: UICollectionViewController,UICollectionViewDelegateFlowLayout {
      
      open var items = [U]()
      init() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            super.init(collectionViewLayout: layout)
      }
      let cellID = "cellID"
      required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
      }
      
      private let loadingIndicator: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.hidesWhenStopped = true
            return spinner
      }()
      
      func showLoading() {
            loadingIndicator.startAnimating()
      }
      func hideLoading() {
            loadingIndicator.stopAnimating()
      }

      open override func viewDidLoad() {
            super.viewDidLoad()
            
            self.collectionView.register(T.self, forCellWithReuseIdentifier: cellID)
            self.collectionView.backgroundColor = .systemBackground
            self.collectionView.alwaysBounceVertical = true
            
            self.navigationController?.navigationBar.tintColor = .accentColor
            self.navigationController?.navigationBar.prefersLargeTitles = true
            
            self.view.addSubview(loadingIndicator)
            loadingIndicator.centerInSuperview()
      }
      
      open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! T
            cell.item = items[indexPath.item]
            return cell
      }
      open override func numberOfSections(in collectionView: UICollectionView) -> Int {
           1
      }
      open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            items.count
      }
      public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            .init(width: view.frame.width, height: 50)
      }
      public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            .zero
      }
      public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            0
      }
      public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            0
      }
      /// - Tag: highlight
      public override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
          if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.backgroundColor = UIColor.accentColor.withAlphaComponent(0.6)
          }
      }
      
      public override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
          if let cell = collectionView.cellForItem(at: indexPath) {
              cell.contentView.backgroundColor = nil
          }
      }
}
