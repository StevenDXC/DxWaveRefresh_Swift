//
//  ViewController.swift
//  WaveRefreshDemo
//
//  Created by Miutrip on 2016/12/29.
//  Copyright © 2016年 dx. All rights reserved.
//

import UIKit
import WaveRefreshView

class ViewController: UIViewController,UIScrollViewDelegate {

    var contentView:WaveRefreshView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImageView = UIImageView.init(frame: view.bounds);
        bgImageView.image = UIImage.init(named: "image");
        view.addSubview(bgImageView);
        
        let scrollView = UIScrollView.init(frame:self.view.bounds);
        scrollView.delegate = self;
        scrollView.contentSize = CGSize(width:self.view.bounds.width,height:1000);
        view.addSubview(scrollView);
        
        contentView = WaveRefreshView(frame: CGRect(x:0,y:0,width:view.bounds.width,height:1000));
        contentView!.topMargin = 200;
        contentView!.waveAmplitude = 15;
        contentView!.angle = 10;
        contentView!.waveAnimationDuration = 1.6;
        scrollView.addSubview(contentView!)
        
        let avatarImageView = CircleImageView.init(frame:CGRect(x:0,y:0,width:48,height:48));
        avatarImageView.center = CGPoint(x:view.bounds.midX,y:100);
        avatarImageView.image = UIImage.init(named: "avatar");
        contentView!.addSubview(avatarImageView);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y <= 0 && scrollView.contentOffset.y >= -100 && contentView?.isRefreshing() == false){
            let progress = -scrollView.contentOffset.y/100.0;
            contentView?.progress = progress;
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(scrollView.contentOffset.y <= -100){
            contentView?.progress = 1.0;
            contentView?.startRefreshing();
            DispatchQueue.main.asyncAfter(wallDeadline: .now()+5, execute: {
                self.stopRefreshing();
            });
        }
    }
    
    func stopRefreshing(){
        contentView?.stopRefreshing();
    }

}

