//
//  LoadingFooterView.swift
//  Music
//
//  Created by Sann Chhailong on 21/3/22.
//

import UIKit

class LoadingFooterView: UICollectionReusableView {
      override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(loadingIndicator)
            loadingIndicator.centerInSuperview()
      }
      
      required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
      }
      
      
      let loadingIndicator: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.hidesWhenStopped = true
            return spinner
      }()
      
      
}


class TitleHeaderView: UICollectionReusableView {
      override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(titleLabel)
            titleLabel.fillSuperview(padding: .symentic(vertical: 0, horizontal: 16))
      }
      
      required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
      }
      
      
      let titleLabel: UILabel = {
            let font = UIFont.preferredFont(forTextStyle: .headline)
            let label = UILabel(text: "Recently Added", font: font, textColor: .label, textAlignment: .left, numberOfLines: 1)
            return label
      }()
      
      
}
