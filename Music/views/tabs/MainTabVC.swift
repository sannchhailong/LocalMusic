//
//  MainTabVC.swift
//  Music
//
//  Created by Sann Chhailong on 23/3/22.
//

import UIKit


class MainTabVC: UITabBarController {
    
    
    lazy var tabContainer: UIView = {
        let v = UIView(backgroundColor: .clear)
        
        return v
    }()
    
    lazy var mediaControlView: MainControlsView = {
        let v = MainControlsView()
        v.playPauseButton.addTarget(self, action: #selector(playPauseAction(sender:)), for: .touchUpInside)
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFullscreenPlayer(sender:))))
        return v
    }()
    
    @objc func playPauseAction(sender: UIButton) {
        if let image = sender.image(for: .normal) {
            if image == UIImage(systemName: "play.fill") {
                NotificationCenter.default.post(name: .playTrack, object: nil, userInfo: nil)
            } else {
                NotificationCenter.default.post(name: .pauseTrack, object: nil, userInfo: nil)
            }
        }
    }
    @objc func showFullscreenPlayer(sender: UITapGestureRecognizer) {
        self.present(FullscreenPlayerVC(), animated: true)
    }
    lazy var separator: UIView = {
        let v = UIView(backgroundColor: .systemGray3)
        
        return v
    }()
    
    lazy var visualEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemMaterial)
        let v = UIVisualEffectView(effect: effect)
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return v
    }()
    
    var itemStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 0
        return stack
    }()
    
    let playButton: UIButton = {
        let button = UIButton(image: UIImage(systemName: "play.fill")!)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundColor(UIColor.gray.withAlphaComponent(0.6), for: .highlighted)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: ListenNowVC(), title: "Listen Now", imageName: "play.circle.fill"),
            createNavController(viewController: BrowseVC(), title: "Browse", imageName: "square.grid.2x2.fill"),
            createNavController(viewController: RadioVC(), title: "Radio", imageName: "dot.radiowaves.left.and.right"),
            createNavController(viewController: MusicLibraryVC(), title: "Library", imageName: "music.note.list"),
            createNavController(viewController: SearchTrackVC(), title: "Search", imageName: "magnifyingglass"),
        ]
        
        
        
        
        view.addSubview(tabContainer)
        tabContainer.anchor(
            .bottom(view.bottomAnchor, constant: 0),
            .leading(view.leadingAnchor, constant: 0),
            .trailing(view.trailingAnchor, constant: 0),
            .bottom(tabBar.topAnchor, constant: 0)

        )
        
        tabContainer.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        
        tabContainer.addSubview(mediaControlView)
        mediaControlView.fillSuperview()

//        mediaControlView.anchor(
//            .leading(tabContainer.leadingAnchor, constant: 0),
//            .trailing(tabContainer.trailingAnchor, constant: 0),
//            .top(tabContainer.topAnchor, constant: 0),
//            .bottom(tabContainer.safeAreaLayoutGuide.bottomAnchor, constant: 0)
//
//        )
        
        
//        tabContainer.addSubview(separator)
//        separator.anchor(
//            .leading(tabContainer.leadingAnchor, constant: 0),
//            .trailing(tabContainer.trailingAnchor, constant: 0),
//            .top(mediaControlView.bottomAnchor, constant: 0),
//            .height(0.4)
//        )
//
//        tabContainer.addSubview(itemStackView)
//        itemStackView.anchor(
//            .leading(tabContainer.leadingAnchor, constant: 0),
//            .trailing(tabContainer.trailingAnchor, constant: 0),
//            .top(separator.bottomAnchor, constant: 2),
//            .bottom(tabContainer.safeAreaLayoutGuide.bottomAnchor, constant: 0)
//        )
        
//        viewControllers?.enumerated().forEach({ (i,v) in
//            guard let nav = v as? UINavigationController,
//                  let tabBarItem = nav.tabBarItem else {return}
//
//            let button = UIButton()
//            button.setImage(tabBarItem.image, for: .normal)
//
//            if i == selectedIndex {
//                button.tintColor = .accentColor
//            } else {
//                button.tintColor = .secondaryLabel
//            }
//
//            button.tag = i
//            button.addTarget(self, action: #selector(onItemTapped(sender:)), for: .touchUpInside)
//            itemStackView.addArrangedSubview(button.withHeight(40))
//        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(musicPlay(notification:)), name: .playTrack, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(musicPause(notification:)), name: .pauseTrack, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(musicStop(notification:)), name: .stopTrack, object: nil)
        AssetsLoader.shared.saveDefaultAsset()

    }
    
    
    // MARK: Play track event observer
    
    @objc func musicPlay(notification: NSNotification) {
        self.mediaControlView.playPauseButton.setImage(UIImage(systemName: "pause.fill")!, for: .normal)
        if let song = notification.object as? Song {
            self.mediaControlView.titleLabel.text = song.title
            if let imageData = song.artwork?.imageData,
               let image = UIImage(data: imageData) {
                self.mediaControlView.artworkImage.image = image
            } else {
                self.mediaControlView.artworkImage.image = .defaultAlbumImage2.withRenderingMode(.alwaysTemplate)
            }
        }
    }

    @objc func musicPause(notification: NSNotification) {
        self.mediaControlView.playPauseButton.setImage(UIImage(systemName: "play.fill")!, for: .normal)
    }
    
    @objc func musicStop(notification: NSNotification) {
        self.mediaControlView.playPauseButton.setImage(UIImage(systemName: "play.fill")!, for: .normal)
    }
    
    
    @objc func onItemTapped(sender: UIButton) {
        selectedIndex = sender.tag
        self.itemStackView.arrangedSubviews.forEach { v in
            if let item = v as? UIButton {
                if item.tag == selectedIndex {
                    item.tintColor = .accentColor
                } else {
                    item.tintColor = .secondaryLabel
                }
            }
        }
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.badgeColor = .accentColor
        navController.tabBarItem.title = title
        viewController.navigationItem.title = title
        
        
        navController.tabBarItem.image = UIImage(systemName: imageName)
        return navController
        
    }
    
}

import SwiftUI

struct MainPreview: PreviewProvider {
    static var previews: some View {
        
        Group {
            MainTabView()
                .ignoresSafeArea()
                .preferredColorScheme(.light)
                .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        }
    }
    
    struct MainTabView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return MainTabVC()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
