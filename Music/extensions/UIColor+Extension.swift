//
//  UIColor+Extension.swift
//  testing
//
//  Created by Sann Chhailong on 11/3/22.
//
import UIKit

extension UIColor {
    static var accentColor: UIColor {
          UIColor(named: "accent")!
    }
    static var endGradientColor: UIColor {
        #colorLiteral(red: 0.2235294118, green: 0.2862745098, blue: 0.6705882353, alpha: 1)
    }
    
    static var lightBlue: UIColor {
        #colorLiteral(red: 0.1254901961, green: 0.7490196078, blue: 0.9764705882, alpha: 1)
    }
    static var placeholder: UIColor {
        #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
    }
    static public func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static var random: UIColor {
        
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)

    }

}

import SwiftUI
extension Color {
    static var accentColor: Color {
          Color("accent")
    }
    static var endGradientColor: Color {
        Color(uiColor: .endGradientColor)
    }
    
    static var lightBlue: Color {
        Color(uiColor: .lightBlue)
    }
    static var placeholder: Color {
        Color(uiColor: .placeholder)
    }
    static public func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> Color {
        return Color(uiColor: .rgb(red: red, green: green, blue: blue))
    }
    
    static var random: Color {
        
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)

    }

}
