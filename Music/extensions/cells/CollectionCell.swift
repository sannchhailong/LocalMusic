//
//  CollectionCell.swift
//  Music
//
//  Created by Sann Chhailong on 12/3/22.
//

import UIKit

open class CollectionCell<T>: UICollectionViewCell {
      
      open var item: T!
      public let separatorView = UIView(backgroundColor: UIColor(white: 0.6, alpha: 0.3))
      
      /// This convenience method sets up the separate line with some left padding
      open func addSeparatorView(leftPadding: CGFloat = 0) {
          addSubview(separatorView)
          separatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: leftPadding, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
      }
      /// This sets up the separator to be anchored to some leading anchor
      open func addSeparatorView(leadingAnchor: NSLayoutXAxisAnchor) {
          addSubview(separatorView)
          separatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 0.5))
      }
      
      override public init(frame: CGRect) {
          super.init(frame: frame)
            
          setupViews()
      }
      
      /// In your custom ListCell classes, just override setupViews() to provide custom behavior.  We do this to avoid overriding init methods.
      open func setupViews() {}
      
      required public init?(coder aDecoder: NSCoder) {
          fatalError()
      }
}
