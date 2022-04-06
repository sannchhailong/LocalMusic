//
//  MainControlsView.swift
//  Music
//
//  Created by Sann Chhailong on 25/3/22.
//

import UIKit

class MainControlsView: UIView {
    
    lazy var artworkImage: UIImageView = {
        let iv = UIImageView(image: .defaultAlbumImage2.withRenderingMode(.alwaysTemplate))
        iv.backgroundColor = .label.withAlphaComponent(0.2)
        iv.tintColor = .label.withAlphaComponent(0.4)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(text: "Not playing",font: .systemFont(ofSize: 18,weight: .regular))
        
        return label
    }()
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton(image: UIImage(systemName: "play.fill")!)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundColor(UIColor.gray.withAlphaComponent(0.6), for: .highlighted)
        
        return button
    }()
    lazy var previusButton: UIButton = {
        let button = UIButton(image: UIImage(systemName: "backward.fill")!)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundColor(UIColor.gray.withAlphaComponent(0.6), for: .highlighted)
        
        return button
    }()
    lazy var nextButton: UIButton = {
        let button = UIButton(image: UIImage(systemName: "forward.fill")!)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundColor(UIColor.gray.withAlphaComponent(0.6), for: .highlighted)
        
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addRow(
            artworkImage.withSize(.square(50)),
            titleLabel,
            playPauseButton.withSize(.square(40)),
            nextButton.withSize(.square(40)),
            spacing: 12,
            alignment: .center,
            distribution: .fill).padSymentic(vertical: 8, horizontal: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with frame has not been initialed")
    }
}



import SwiftUI

struct MainControlPreview: PreviewProvider {
    static var previews: some View {
        
        Group {
            MainControls()
                .ignoresSafeArea()
                .preferredColorScheme(.dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        }
    }
    
    struct MainControls: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> some UIViewController {
            let vc = UIViewController()
            let v = MainControlsView()
            vc.view.addSubview(v)
            v.anchor(
                .leading(vc.view.leadingAnchor, constant: 0),
                .trailing(vc.view.trailingAnchor, constant: 0)
            )
            v.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
            v.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
            
            return vc
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
