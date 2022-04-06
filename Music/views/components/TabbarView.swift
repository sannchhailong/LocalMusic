//
//  TabbarView.swift
//  Music
//
//  Created by Sann Chhailong on 25/3/22.
//

import UIKit


class TabbarView: UIView {
    
    lazy var tabContainer: UIView = {
        let v = UIView(backgroundColor: .clear)
        
        return v
    }()
    
    lazy var playButtonContainer: UIView = {
        let v = UIView(backgroundColor: .clear)
        
        return v
    }()
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
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "play.fill")
        config.imagePadding = 8
        config.setDefaultContentInsets()
        config.baseBackgroundColor = .clear
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.tintColor = .white
        button.setBackgroundColor(UIColor.white.withAlphaComponent(0.3), for: .selected)
        button.setBackgroundColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted)

        return button
    }()
    
    var children: [UIViewController] = []
    
    init(children: [UIViewController]) {
        self.children = children
        super.init(frame: .zero)
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
