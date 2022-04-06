//
//  TrackCell.swift
//  Music
//
//  Created by Sann Chhailong on 17/3/22.
//

import UIKit

class TrackCell: CollectionCell<Song> {
    
    static let albumImageSize: CGFloat = 48
    static let verticalPadding: CGFloat = 4
    override var item: Song! {
        didSet {
            if let data = item.artwork?.imageData,
               let image = UIImage(data: data) {
                self.albumCover.image = image
            } else {
                self.albumCover.image = .defaultAlbumImage2.withRenderingMode(.alwaysTemplate)
            }
            self.titleLabel.text = item.title
            self.subtitleLabel.text = item.artist
        }
    }
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
    override func setupViews() {
        super.setupViews()
        contentView.addRow(
            albumCover.withSize(.square(TrackCell.albumImageSize)),
            addColumn(titleLabel,subtitleLabel, spacing: 4, alignment: .fill, distribution: .fill),
            spacing: 16, alignment: .center, distribution: .fill
        ).padSymentic(vertical: TrackCell.verticalPadding, horizontal: 16)
        self.addSeparatorView(leftPadding: 50+32)
    }
}
