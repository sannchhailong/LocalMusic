//
//  TrackPlayerVC.swift
//  Music
//
//  Created by Sann Chhailong on 22/3/22.
//

import UIKit

class FullscreenPlayerVC: UIViewController {
      
      lazy var artworkBackground: UIImageView = {
            let iv = UIImageView(image: UIImage(named: "recovery"))
            iv.contentMode = .scaleAspectFill
            
            return iv
      }()
      
      lazy var visualEffectView: UIVisualEffectView = {
            let effect = UIBlurEffect(style: .systemMaterialDark)
            let v = UIVisualEffectView(effect: effect)
            v.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            return v
      }()
      
      
      lazy var artworkIV: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.borderWidth = 4
            return iv
      }()
      
      override func viewDidLoad() {
            super.viewDidLoad()
            
            
            view.addSubview(artworkBackground)
            artworkBackground.fillSuperview(padding: .allSides(-100))
            
            view.addSubview(visualEffectView)
            visualEffectView.fillSuperview()
            
            view.addSubview(artworkIV)
            let wid = view.frame.width - 40
            
            artworkIV.anchor(
                  .leading(view.leadingAnchor, constant: 20)
            )
      }
}
