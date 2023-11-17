//
//  MusicLibraryVC.swift
//  Music
//
//  Created by Sann Chhailong on 12/3/22.
//

import UIKit
import AVFoundation

class MusicLibraryVC: UICollectionViewController {
    var loading = true
    var items: [LibraryItem] = [
        .init(icon: "music.note.list", title: "Playlists"),
        .init(icon: "music.mic", title: "Artists"),
        .init(icon: "square.stack", title: "Albums"),
        .init(icon: "music.note", title: "Songs"),
        .init(icon: "music.note.tv", title: "Music Videos"),
        .init(icon: "guitars", title: "Genres"),
        .init(icon: "person.2.crop.square.stack", title: "Compilations"),
        .init(icon: "music.quarternote.3", title: "Composers"),
        .init(icon: "arrow.down.circle", title: "Downloaded")
    ]
    
    var songs = [Song]()
    
    //      var albums = [UIImage]()
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    let cellID = "cellID"
    let albumCellID = "albumCellID"
    let footerID = "footerID"
    let headerID = "headerID"
    let padding: CGFloat = 16
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Library"
        
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction(sender:)))
        self.navigationItem.rightBarButtonItem = editButton
        
        
        self.collectionView.register(LibraryCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: albumCellID)
        self.collectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerID)
        self.collectionView.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .systemBackground
        
        
        self.navigationController?.navigationBar.tintColor = .accentColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //            let appearance = UINavigationBarAppearance()
        //            appearance.configureWithOpaqueBackground()
        //            appearance.backgroundColor = .red
        //            self.navigationController?.navigationBar.standardAppearance = appearance
        //            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        getMusicLibrary()
        
        
        
        // MARK: TRY DECODING
        
        let json: [String: String] = [
            "icon": "music.note.tv",
            "title": "Music Videos"
        ]
        
        do {
            let data = try JSONEncoder().encode( [
                "icon": "music.note.tv",
                "title": "Music Videos"
            ])
            
            let item = try JSONDecoder().decode(LibraryItem.self, from: data)
            print(item.toJSON())
            
        } catch {
            print(error)
        }
        
    }
    
    @objc func editAction(sender: UIBarButtonItem) {
        present(FullscreenPlayerVC(), animated: true)
    }
    
    func getMusicLibrary() {
        Task {
            AssetsLoader.shared.loadAllTracks({ (tracks,error) in
                if let tracks = tracks {
                    self.songs = tracks
                    
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            })
        }
    }
}

extension MusicLibraryVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return  .init(width: view.frame.width, height: 60)
        } else {
            let wid = (view.frame.width - padding * 3) / 2
            return  .init(width: wid, height: wid + 50)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! LibraryCell
            cell.item = items[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumCellID, for: indexPath) as! AlbumCell
            cell.item = songs[indexPath.item]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return padding
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        }
        return .init(top: padding, left: padding, bottom: 80, right: padding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let title = items[indexPath.row].title
            if title.lowercased() == "songs" {
                let vc = TrackListingVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.section == 1 {
            NotificationCenter.default.post(name: .playTrack, object: self.songs[indexPath.item])
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return items.count
        }
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if (section == 1) {
            return .init(width: view.frame.width, height: 60)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (section == 1) {
            return .init(width: view.frame.width, height: 40)
        }
        return .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! TitleHeaderView
            
            return header
        } else{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerID, for: indexPath) as! LoadingFooterView
            if loading {
                footer.loadingIndicator.startAnimating()
            } else {
                footer.loadingIndicator.stopAnimating()
            }
            return footer
        }
    }
}
