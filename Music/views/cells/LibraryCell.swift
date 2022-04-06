//
//  LibraryCell.swift
//  Music
//
//  Created by Sann Chhailong on 12/3/22.
//

import UIKit

class LibraryCell: CollectionCell<LibraryItem> {
      
      
      let icon: UIImageView = {
            let iv = UIImageView(image: UIImage(systemName: "book.fill"))
            iv.contentMode = .scaleAspectFit
            return iv
      }()
      let arrowIcon: UIImageView = {
            let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
            iv.contentMode = .scaleAspectFit
            iv.tintColor = .gray
            return iv
      }()
      let titleLabel = UILabel(text: "Songs", font: .systemFont(ofSize: .fontSizeDefault), textColor: .label, textAlignment: .left, numberOfLines: 1)
      override var item: LibraryItem! {
            didSet {
                  icon.image = UIImage(systemName: item.icon)
                  titleLabel.text = item.title
            }
      }
      
      override func setupViews() {
            addSeparatorView(leftPadding: 12)
            tintColor = .accentColor
            contentView.addRow(
                  icon.withSize(.square(26)),
                  titleLabel,
                  arrowIcon.withSize(.square(16)),
                  spacing: 12, alignment: .center, distribution: .fill
            ).padSymentic(vertical: 16, horizontal: 12)
      }
      
}
