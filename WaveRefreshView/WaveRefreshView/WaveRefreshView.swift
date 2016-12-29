//
//  WaveRefreshView.swift
//  WaveRefreshView
//
//  Created by Miutrip on 2016/12/29.
//  Copyright © 2016年 dx. All rights reserved.
//

import UIKit

public enum Gravity {
    case left
    case right
}


public class WaveRefreshView: UIView,CAAnimationDelegate  {
    
    public var bgColor:UIColor = UIColor.white;
    
    
    public var topMargin:CGFloat = 160;
    
    //the amplitude of wave shape
    public var waveAmplitude:CGFloat = 15;
    
    //the angle of oblique view
    public var angle:CGFloat = 10;
    
    public var gravity:Gravity = .left;
    
    public var waveAnimationDuration:CGFloat = 1.6;
    
    
    private var bgLayer:ShapeBackgroundLayer?;
    private var waveView:WaveView?;
    private var isLoadingAnimationRuning:Bool = false;
    
    
    public var progress : CGFloat {
        get { return bgLayer!.progress  }
        set {
            bgLayer!.progress = newValue;
            bgLayer?.setNeedsDisplay();
        }
    }
    
    required override public init(frame:CGRect) {
        super.init(frame:frame)
        bgLayer = ShapeBackgroundLayer();
        bgLayer!.shapeAngle = angle;
        bgLayer?.gravity = gravity;
        bgLayer!.contentsScale = UIScreen.main.scale;
        self.layer.addSublayer(bgLayer!);
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        bgLayer?.frame = CGRect(x: 0, y: topMargin, width: bounds.size.width, height: bounds.size.height-topMargin);
        bgLayer?.setNeedsDisplay();
    }
    
    
    //MARK: CAAnimationDelegate
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        isLoadingAnimationRuning = false;
        bgLayer?.removeAllAnimations();
    }
    
    
    private func restoreShapeLayerWithAnimation(){
        bgLayer?.progress = 0.0;
        let animation = CABasicAnimation(keyPath: "progress");
        animation.fromValue = 1.0;
        animation.toValue = 0.0;
        animation.isRemovedOnCompletion = false;
        animation.duration = 0.25;
        animation.delegate = self;
        animation.fillMode = kCAFillModeBackwards;
        bgLayer?.add(animation, forKey: "shape");
    }
    
    public func isRefreshing() -> Bool{
        return isLoadingAnimationRuning;
    }
    
    //start play loading animation
    public func startRefreshing(){
        
        if(isLoadingAnimationRuning){
            return;
        }
        
        isLoadingAnimationRuning = true;
        waveView = WaveView(frame:CGRect(x:0,y:topMargin-waveAmplitude*2+1,width:bounds.width,height:waveAmplitude*2));
        waveView?.color = bgColor;
        waveView?.waveAnimationDuration = waveAnimationDuration;
        waveView?.startAnimation();
        self.addSubview(waveView!)
        
    }
    
    //stop play loading animation
    public func stopRefreshing(){
        self.waveView?.removeFromSuperview();
        self.restoreShapeLayerWithAnimation();
    }

}
