//
//  ProgressView.swift
//  testing
//
//  Created by Sann Chhailong on 11/3/22.
//

import Foundation
import UIKit


class ProgressViewController: UIViewController {
    let progressView: ProgressView
    init(color: UIColor, lineWidth: CGFloat, radius: CGFloat) {
        progressView = ProgressView(color: .blue, lineWidth: 5, radius: 50)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.center = self.view.center
        view.addSubview(progressView)
        progressView.fillSuperview()
        progressView.animateStroke()
    }
}
class ProgressView: UIView {
    
    init(frame: CGRect,
         color: UIColor,
         lineWidth: CGFloat,
         radius: CGFloat
    ) {
        self.color = color
        self.lineWidth = lineWidth
        self.radius = radius
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    convenience init(color: UIColor, lineWidth: CGFloat, radius: CGFloat) {
        self.init(frame: .zero, color: color, lineWidth: lineWidth, radius: radius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(ovalIn:
                                    CGRect(
                                        x: 0,
                                        y: 0,
                                        width: self.radius,
                                        height: self.radius
                                    )
        )
        shapeLayer.path = path.cgPath
    }
    let color: UIColor
    let lineWidth: CGFloat
    let radius: CGFloat
    private lazy var shapeLayer: ProgressShapeLayer = {
        return ProgressShapeLayer(strokeColor: color, lineWidth: lineWidth)
    }()
    
    // MARK: - Animations
    func animateStroke() {
        
        let startAnimation = StrokeAnimation(
            type: .start,
            beginTime: 0.25,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )
        let endAnimation = StrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]
        shapeLayer.add(strokeAnimationGroup, forKey: nil)
        shapeLayer.frame.origin = .init(x: center.x - radius / 2, y: center.y - radius / 2)
        self.layer.addSublayer(shapeLayer)
    }
    
    
}



class ProgressShapeLayer: CAShapeLayer {
    
    public init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()
        
        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class StrokeAnimation: CABasicAnimation {
    
    // 1
    enum StrokeType {
        case start
        case end
    }
    
    // 2
    override init() {
        super.init()
    }
    
    // 3
    init(type: StrokeType,
         beginTime: Double = 0.0,
         fromValue: CGFloat,
         toValue: CGFloat,
         duration: Double) {
        
        super.init()
        
        self.keyPath = type == .start ? "strokeStart" : "strokeEnd"
        
        self.beginTime = beginTime
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.timingFunction = .init(name: .easeInEaseOut)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
