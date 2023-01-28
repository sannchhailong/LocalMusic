//
//  TrackListingVC.swift
//  Music
//
//  Created by Sann Chhailong on 17/3/22.
//

import UIKit
import AVFoundation

class TrackListingVC: CollectionController<TrackCell,Song> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Songs"
        self.showLoading()
        DispatchQueue.background(delay: 0) {
            AssetsLoader.shared.loadAllTracks({ (tracks,error) in
                if let tracks = tracks {
                    self.items = tracks
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            })
        } completion: {
            self.hideLoading()
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: TrackCell.albumImageSize + TrackCell.verticalPadding * 2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: .playTrack, object: self.items[indexPath.item])
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 120, right: 0)
    }
}
