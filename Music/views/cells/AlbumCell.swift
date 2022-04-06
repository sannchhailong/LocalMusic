//
//  AlbumCell.swift
//  Music
//
//  Created by Sann Chhailong on 13/3/22.
//

import UIKit

class AlbumCell: CollectionCell<Song> {
    
    
    let albumCover: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .label.withAlphaComponent(0.2)
        iv.tintColor = .label.withAlphaComponent(0.4)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    let titleLabel = UILabel(text: "Songs", font: .systemFont(ofSize: 16), textColor: .label, textAlignment: .left, numberOfLines: 1)
    let subtitleLabel = UILabel(text: "Songs", font: .systemFont(ofSize: 14), textColor: .secondaryLabel, textAlignment: .left, numberOfLines: 1)
    override var item: Song! {
        didSet {
            if let data = item.artwork?.imageData,
               let image = UIImage(data: data) {
                albumCover.image = image
            } else {
                albumCover.image = .defaultAlbumImage2.withRenderingMode(.alwaysTemplate)
            }
            titleLabel.text = item.title
            subtitleLabel.text = item.artist
            
        }
    }
    
    override func setupViews() {
        contentView.addColumn(
            albumCover,
            titleLabel,
            subtitleLabel, spacing: 6, alignment: .fill, distribution: .fill)
        albumCover.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
}
