//
//  PopoverBackgroundView.swift
//
//  Created by Jason Wolkovitz on 10/1/17.
//

import UIKit

public class PopoverBackgroundView : UIPopoverBackgroundView {
    
    let arrowView:PopoverArrowView
    let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var _arrowOffset: CGFloat = 0
    var _arrowDirection: UIPopoverArrowDirection = UIPopoverArrowDirection.any
    
    override public var arrowDirection: UIPopoverArrowDirection {
        get { return self._arrowDirection }
        set { self._arrowDirection = newValue }
    }
    
    override public var arrowOffset : CGFloat {
        get { return self._arrowOffset }
        set { self._arrowOffset = newValue }
    }
    
    override public class func arrowBase() -> CGFloat { return PopoverBackgroundConditioner.shared.arrowSize.width }
    override public class func arrowHeight() -> CGFloat { return PopoverBackgroundConditioner.shared.arrowSize.height }
 
    override public class func contentViewInsets() -> UIEdgeInsets {
        return PopoverBackgroundConditioner.shared.insets
    }

    override init(frame:CGRect) {
        arrowView = PopoverArrowView(width:PopoverBackgroundView.arrowBase(), height:PopoverBackgroundView.arrowHeight())
        arrowView.tintColor = .red
        backgroundView.layer.cornerRadius = 2.0
        super.init(frame:frame)
        PopoverBackgroundConditioner.shared.currentBackground = self
        addSubview(self.arrowView)
        isOpaque = false
        layer.shadowColor = UIColor.clear.cgColor
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        var height = self.frame.size.height
        var width = self.frame.size.width
        var left: CGFloat = 0.0
        var top: CGFloat = 0.0
        var coordinate: CGFloat = 0.0
        var rotation = CGAffineTransform.identity
        
        switch (self.arrowDirection) {
        case .up:
            top += arrowView.height
            height -= arrowView.height
            coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (arrowView.width/2)
            self.arrowView.frame = CGRect(x: coordinate, y: 0, width: arrowView.width, height: arrowView.height)
            break
            
        case .down:
            height -= arrowView.height
            coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (arrowView.width/2)
            arrowView.frame = CGRect(x: coordinate, y: height, width: arrowView.width, height: arrowView.height)
            rotation = CGAffineTransform(rotationAngle:.pi)
            break
            
        case .left:
            left += arrowView.width
            width -= arrowView.width
            coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (arrowView.height / 2)
            arrowView.frame = CGRect(x: 0, y: coordinate, width: arrowView.width, height: arrowView.height)
            rotation = CGAffineTransform( rotationAngle: -1 * .pi / 2)
            break
            
        case .right:
            width -= arrowView.width
            coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (arrowView.height / 2)
            arrowView.frame = CGRect(x: width, y: coordinate, width: arrowView.width, height: arrowView.height)
            rotation = CGAffineTransform( rotationAngle: .pi / 2)
            break
            
        default:
            break
        }
        
        self.layer.shadowColor = UIColor.clear.cgColor
        self.backgroundView.frame = CGRect(x: left, y: top, width: width, height: height)
        self.arrowView.transform = rotation
    }
    
    class PopoverArrowView: UIView {
        let width: CGFloat
        let height: CGFloat
        
        init(width: CGFloat, height: CGFloat) {
            self.width = width
            self.height = height
            super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
            self.backgroundColor = UIColor.clear
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: width / 2, y: 0))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.close()
            PopoverBackgroundConditioner.shared.arrowColor.setFill()
            path.fill()
        }
    }
}
