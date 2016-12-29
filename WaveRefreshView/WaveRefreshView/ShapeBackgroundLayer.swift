//
//  shapeBgLayer.swift
//  WaveRefreshView
//
//  Created by Miutrip on 2016/12/14.
//  Copyright © 2016年 dx. All rights reserved.
//

import UIKit

class ShapeBackgroundLayer: CALayer {

    public var progress:CGFloat = 0.0;
    public var shapeAngle:CGFloat = 15.0;
    public var gravity:Gravity = .left;
    
    private let path = UIBezierPath();
    private var offset:CGFloat = 0;
    
    public func getSideOffset() -> CGFloat{
        return offset;
    }
    
    override static func needsDisplay(forKey key:String) -> Bool {
        if ("progress" == key) {
            return true;
        }
        return super.needsDisplay(forKey: key);
    }
    
    
    override func draw(in ctx: CGContext) {
        
        path.removeAllPoints();
        
        if(offset == 0){
            offset = self.bounds.width * tan(CGFloat(M_PI)/(180.0/shapeAngle))/2;
        }
        
        var leftTop:CGFloat = 0;
        var rightTop:CGFloat = 0;
        
        if(gravity == .left){
            leftTop = offset * (1.0 - progress);
            rightTop = 0;
        }else{
            leftTop = 0;
            rightTop = offset * (1.0 - progress);
        }
        
        path.move(to: CGPoint(x:0,y:leftTop));
        path.addLine(to: CGPoint(x:self.bounds.width,y:rightTop));
        path.addLine(to: CGPoint(x:self.bounds.width,y:self.bounds.height));
        path.addLine(to: CGPoint(x:0,y:self.bounds.height));
        path.close();

        ctx.addPath(path.cgPath);
        ctx.setFillColor(UIColor.white.cgColor);
        ctx.fillPath();
    }

}
