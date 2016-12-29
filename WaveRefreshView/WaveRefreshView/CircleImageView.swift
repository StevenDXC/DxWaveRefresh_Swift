//
//  CircleImageView.swift
//  WaveRefreshView
//
//  Created by Miutrip on 2016/12/15.
//  Copyright © 2016年 dx. All rights reserved.
//

import UIKit

public class CircleImageView: UIImageView {

    
    public var ci_borderWidth:CGFloat = 0.0;
    public var ci_borderColor:UIColor = UIColor.white;
    
    required override public init(frame:CGRect) {
        super.init(frame:frame)
        self.layer.cornerRadius = self.bounds.width/2;
        self.layer.masksToBounds = true;
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CircleImageView {
    
    fileprivate func circleImage(image:UIImage) -> UIImage{
        
        let size = self.bounds.size;
        let scale = UIScreen.main.scale;
        let cornerRadius = self.bounds.width/2;
        let cornerRadii = CGSize(width:cornerRadius,height:cornerRadius);
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale);
        let currentContext = UIGraphicsGetCurrentContext();
        if nil == currentContext{
            return UIImage();
        }
        let cornerPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: cornerRadii);
        let backgroundRect = UIBezierPath.init(rect: self.bounds);
        self.backgroundColor?.setFill();
        backgroundRect.fill();
        cornerPath.addClip();
        self.layer.render(in: currentContext!);
        drawBorder(path: cornerPath);
        let processedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return processedImage!;
    }
    
    private func drawBorder(path:UIBezierPath) {
        if (0 != self.ci_borderWidth) {
            path.lineWidth = 2 * self.ci_borderWidth;
            ci_borderColor.setStroke();
            path.stroke();
         }
    }
    
}
