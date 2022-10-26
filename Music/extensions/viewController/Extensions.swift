//
//  Extensions.swift
//  CamDigiKey
//
//  Created by Sann Chhailong on 17/5/21.
//

import Foundation
import UIKit


enum AlelrtType {
      case infoAlert(title: String? = nil, message: String, buttonTitle: String = "OK")
      case actionAlert(title: String, message: String, buttonTitle: String)
}


extension CGFloat {
      static var paddingSmall: CGFloat {
            10
      }
      static var paddingMedium: CGFloat {
            16
      }
      static var padding: CGFloat {
            20
      }
      static var paddingLarge: CGFloat {
            30
      }
      
      // MARK: font size
      static var fontSizeXSmall: CGFloat {
            12
      }
      static var fontSizeSmall: CGFloat {
            14
      }
      static var fontSizeDefault: CGFloat {
            18
      }
      static var fontSizeLarge: CGFloat {
            24
      }
      static var fontSizeXLarge: CGFloat {
            36
      }
      
      static var faceScannerAreaWid: CGFloat {  UIScreen.main.bounds.width * (DeviceType.IS_IPAD ? 0.6 : 0.9)
      }
      
      
}
extension UIWindow {
      var topViewController: UIViewController? {
            guard var top = rootViewController else {
                  return nil
            }
            while let next = top.presentedViewController {
                  top = next
            }
            return top
      }
}

extension UINavigationController {
      func popViewController(animated: Bool, completion: @escaping () -> Void) {
            popViewController(animated: animated)
            
            if animated, let coordinator = transitionCoordinator {
                  coordinator.animate(alongsideTransition: nil) { _ in
                        completion()
                  }
            } else {
                  completion()
            }
      }
      
      func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
            pushViewController(viewController, animated: animated)
            
            if animated, let coordinator = transitionCoordinator {
                  coordinator.animate(alongsideTransition: nil) { _ in
                        completion()
                  }
            } else {
                  completion()
            }
      }
}


extension UIViewController {
      
    public func changeRootWindow(to viewController: UIViewController, duration: TimeInterval = 0.3, animation: UIView.AnimationOptions = .transitionCrossDissolve ) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate),
               let window = sd.window {
                  window.rootViewController = viewController
                  UIView.transition(with: window, duration: duration, options: animation, animations: {}, completion: {completed in})
            }
      }
      
      func showAlert(_ alertType: AlelrtType,_ handler: ((UIAlertAction) -> ())? = nil) {
            
            var alert: UIAlertController!
            let cancel = UIAlertAction(title: "Cancel", style: .default) {_ in
                  self.dismiss(animated: true)
            }
            let action: UIAlertAction!
            
            switch alertType {
                  case .actionAlert(let title, let message, let buttonTitle):
                        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        action = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
                        alert.addAction(cancel)
                        
                  case let .infoAlert(title,message,buttonTitle):
                        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        action = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
            }
            alert.addAction(action)
            DispatchQueue.main.async { self.present(alert, animated: true, completion: nil) }
      }
      
      
    public var statusBarHeight: CGFloat { view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 }
      
      
//      func showLoading(_ progressView: ProgressView) {
//            DispatchQueue.main.async {
//                  progressView.translatesAutoresizingMaskIntoConstraints = false
//                  progressView.center = self.view.center
//                  self.view.addSubview(progressView)
//                  progressView.fillSuperview()
//                  progressView.animateStroke()
//                  self.view.endEditing(true)
//            }
//      }
//      
//      func hideLoading() {
//            self.view.subviews.forEach { v in
//                  if v.isKind(of: ProgressView.self) {
//                        if let loadingIndicator = v as? ProgressView {
//                              DispatchQueue.main.async { loadingIndicator.removeFromSuperview() }
//                        }
//                  }
//            }
//      }
}

extension UIEdgeInsets {
      static public func symentic(vertical: CGFloat = 0,horizontal: CGFloat = 0) -> UIEdgeInsets {
            return .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
      }
}

extension CGRect {
      func scaled(to size: CGSize) -> CGRect {
            return CGRect(
                  x: self.origin.x * size.width,
                  y: self.origin.y * size.height,
                  width: self.size.width * size.width,
                  height: self.size.height * size.height
            )
      }
}

extension CGPoint {
      func scaled(to size: CGSize) -> CGPoint {
            return CGPoint(x: self.x * size.width, y: self.y * size.height)
      }
}
extension CIImage {
      func getUIImage() -> UIImage{
            let context = CIContext()
            guard let cgImage = context.createCGImage(self, from: self.extent) else { return UIImage() }
            return UIImage(cgImage: cgImage)
      }
}
extension UIImage {
      func base64String() -> String{
            
            let imageData = self.jpegData(compressionQuality: 1)!
            let strBase64 = imageData.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
            return strBase64
      }
      func rotate(radians: CGFloat) -> UIImage {
            let rotatedSize = CGRect(origin: .zero, size: size)
                  .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
                  .integral.size
            UIGraphicsBeginImageContext(rotatedSize)
            if let context = UIGraphicsGetCurrentContext() {
                  let origin = CGPoint(x: rotatedSize.width / 2.0,
                                       y: rotatedSize.height / 2.0)
                  context.translateBy(x: origin.x, y: origin.y)
                  context.rotate(by: radians)
                  draw(in: CGRect(x: -origin.y, y: -origin.x,
                                  width: size.width, height: size.height))
                  let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
                  UIGraphicsEndImageContext()
                  
                  return rotatedImage ?? self
            }
            
            return self
      }
      func resizeImage(targetSize: CGSize) -> UIImage {
            let size = self.size
            
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height
            
            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                  newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                  newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
                  
            }
            
            
            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            
            self.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage!
      }
}


extension UIViewController {
      
      func setUpNavigation(tintColor: UIColor = .white, titleColor: UIColor = .white, prefersLargeTitles: Bool = true) {
            if let nav = navigationController {
                  nav.navigationBar.tintColor = tintColor
                  nav.navigationBar.prefersLargeTitles = prefersLargeTitles
                  nav.navigationBar.largeTitleTextAttributes = [
                        .foregroundColor: titleColor,
                        .font: UIFont.systemFont(ofSize: 22, weight: .medium)
                  ]
                  let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
                  backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
                  let navigationBarAppearance = UINavigationBarAppearance()
                  navigationBarAppearance.backButtonAppearance = backButtonAppearance
                  navigationBarAppearance.setBackIndicatorImage(#imageLiteral(resourceName: "ic_back"), transitionMaskImage: #imageLiteral(resourceName: "ic_back"))
                  navigationBarAppearance.largeTitleTextAttributes = [
                        .foregroundColor: titleColor,
                        .font: UIFont.systemFont(ofSize: 22, weight: .medium)
                  ]
                  nav.navigationBar.standardAppearance = navigationBarAppearance
                  
            }
      }
}
extension TimeInterval {
      func stringFromTimeInterval() -> String {
            
            let ti = NSInteger(self)
            
            //        let ms = Int((self % 1) * 1000)
            
            let seconds = ti % 60
            let minutes = (ti / 60) % 60
            let hours = (ti / 3600)
            if hours > 0 {
                  return String(format: "%0.2d:%0.2d:%0.2d", hours,minutes,seconds)
            }
            
            return String(format: "%0.2d:%0.2d",minutes,seconds)
      }
}

extension Notification.Name {
    static let playTrack = Notification.Name("playTrack")
    static let pauseTrack = Notification.Name("pauseTrack")
    static let stopTrack = Notification.Name("stopTrack")
}

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}
