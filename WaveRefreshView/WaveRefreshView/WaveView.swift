//
//  WaveView.swift
//  WaveRefreshView
//
//  Created by Miutrip on 2016/12/14.
//  Copyright © 2016年 dx. All rights reserved.
//

import UIKit

class WaveView: UIView {

    public var waveAnimationDuration:CGFloat = 1.6;
    
    private var _color:UIColor = UIColor.white;
    
    public var color : UIColor {
        get { return _color  }
        set {
            _color = newValue;
            shapeLayer.fillColor = _color.cgColor;
            shapeLayer.setNeedsDisplay();
        }
    }
    
    fileprivate let shapeLayer: CAShapeLayer = CAShapeLayer();
    fileprivate let keyAnimation:String = "move";
    
    required override init(frame:CGRect) {
        super.init(frame:frame)
        shapeLayer.fillColor = _color.cgColor;
        self.layer.addSublayer(shapeLayer);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width * 2, height: bounds.size.height)
    }
}

//MARK: extension
extension WaveView {
    
    fileprivate func wavePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to:CGPoint(x: 0, y:frame.height * 0.5));
        path.addQuadCurve(to: CGPoint(x: frame.width * 0.5, y: frame.height * 0.5), controlPoint: CGPoint(x: frame.width * 0.25, y: 0));
        path.addQuadCurve(to: CGPoint(x: frame.width * 1, y: frame.height  * 0.5), controlPoint: CGPoint(x: frame.width * 0.75, y: frame.height));
        path.addQuadCurve(to: CGPoint(x: frame.width * 1.5, y: frame.height  * 0.5), controlPoint: CGPoint(x: frame.width * 1.25, y: 0));
        path.addQuadCurve(to: CGPoint(x: frame.width * 2, y: frame.height  * 0.5), controlPoint: CGPoint(x: frame.width * 1.75, y: frame.height));
        
        path.addLine(to: CGPoint(x: frame.width * 2, y: frame.height));
        path.addLine(to: CGPoint(x: 0, y: frame.height));
        path.close();
        
        return path.cgPath;
    }
}

//MARK: animation extension
extension WaveView {
    
    public func startAnimation() {
        shapeLayer.path = wavePath()
        let animation = CABasicAnimation(keyPath: "position.x");
        animation.fromValue = 0;
        animation.toValue = frame.size.width;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear);
        animation.isRemovedOnCompletion = false;
        animation.duration = CFTimeInterval(waveAnimationDuration);
        animation.repeatCount = Float.infinity;
        animation.fillMode = kCAFillModeBackwards;
        shapeLayer.add(animation, forKey: keyAnimation);
    }
    
    public func stopAnimation(){
        let animation = shapeLayer.animation(forKey: keyAnimation);
        if(animation != nil){
            shapeLayer.removeAllAnimations();
        }
    }
}
