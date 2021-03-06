//
//  UIStackView.swift
//  CamDigiKey
//
//  Created by Sann Chhailong on 5/1/19.
//

import UIKit

@available(iOS 11.0, tvOS 11.0, *)
extension UIStackView {
    
    @discardableResult
    open func withMargins(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    @discardableResult
    open func padLeft(_ left: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }
    
    @discardableResult
    open func padTop(_ top: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }
    
    @discardableResult
    open func padBottom(_ bottom: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
    }
    
    @discardableResult
    open func padRight(_ right: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }
    
    @discardableResult
    open func padAll(_ padding: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = padding
        layoutMargins.right = padding
        layoutMargins.bottom = padding
        layoutMargins.top = padding
        return self
    }
    @discardableResult
    open func padSymentic(vertical: CGFloat,  horizontal: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = horizontal
        layoutMargins.right = horizontal
        layoutMargins.bottom = vertical
        layoutMargins.top = vertical
        return self
    }
}
