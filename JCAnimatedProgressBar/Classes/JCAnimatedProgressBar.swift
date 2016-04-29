//
//  JCAnimatedProgressBar.swift
//  JCAnimatedProgressBar
//
//  Created by Jose Angel Cuadrado Mingo on 21/4/16.
//  Copyright © 2016 JC. All rights reserved.
//

import UIKit

struct Constants {
    static let pointsPerSecond = 60.0
}

public class JCAnimatedProgressBar: UIView {

    public var filledColor : UIColor = UIColor() {
        didSet {
            self.filledView.backgroundColor = filledColor
        }
    }
    
    public var hollowColor : UIColor = UIColor() {
        didSet {
            self.hollowView.backgroundColor = hollowColor
        }
    }
    
    public var progressImage : UIImage = UIImage() {
        didSet {
            self.imageView.image = progressImage
        }
    }
    
    public var progress : NSInteger = 0 {
        didSet {
            if (progress > 100) {
                progress = 100
            } else if (progress < 0) {
                progress = 0
            }
            self.progressAdded = abs(progress - oldValue)
            self.setNeedsDisplay()
        }
    }
    
    public var roundedCorner : Bool = false {
        didSet {
            if (roundedCorner) {
                self.layer.cornerRadius = self.bounds.size.height / 2
                self.layer.masksToBounds = true
            } else {
                self.layer.cornerRadius = 0
            }
        }
    }
    
    private var filledView : UIView = UIView()
    private var hollowView : UIView = UIView()
    private var imageView : UIImageView = UIImageView()
    private var progressAdded : NSInteger = 0
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func rotateView() {
        self.updateSubviews()
    }
    
    override public func drawRect(rect: CGRect) {
        let widthAdded:CGFloat = self.bounds.size.width * (CGFloat)(self.progressAdded)/100
        let duration:Double = (Double)(widthAdded) / Constants.pointsPerSecond
        
        if (self.filledView.frame == self.hollowView.frame) {
            updateSubviews()
        } else {
            UIView.animateWithDuration(duration) {
                self.updateSubviews()
            }
        }
    }
    
    private func updateSubviews() {
        let width:CGFloat = self.bounds.size.width * (CGFloat)(self.progress)/100

        self.filledView.frame = CGRect(x: 0, y: 0, width: width, height: self.bounds.size.height)
        self.hollowView.frame = CGRect(x: width, y: 0, width: self.bounds.size.width - width, height: self.bounds.size.height)
        
        self.addSubview(self.filledView)
        self.addSubview(self.hollowView)
        
        let side = self.frame.size.height * 1.5
        self.imageView.frame = CGRect(x: self.frame.origin.x + width - (side/2), y: self.frame.origin.y-(self.frame.size.height * 0.25), width: side, height: side)
        self.superview?.addSubview(self.imageView)
    }

}
