//
//  UILabel.swift
//  CamDigiKey
//
//  Created by Sann Chhailong on 4/26/19.
//  Copyright © 2019 Sann Chhailong. All rights reserved.
//

import UIKit

extension UILabel {
    convenience public init(text: String? = nil, font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = .label, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
