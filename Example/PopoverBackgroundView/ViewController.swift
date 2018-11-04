//
//  ViewController.swift
//  PopoverBackgroundDemo
//
//  Created by Jason Wolkovitz on 11/1/18.
//  Copyright © 2018 Smart Wolf Technology. All rights reserved.
//

import UIKit
import PopoverBackgroundView

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var Button1: UIButton!
    
    @IBOutlet weak var Button2: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Button1.rotate(degrees: -90)
        Button2.rotate(degrees: -90)
    }
    
    // Fullscreen side popover that respects the safe area on iPhone X and iPad pro 3rd generation
    @IBAction func B1(_ sender: Any) {
        let arrowHeight: CGFloat = 20
        let topOffset: CGFloat = 30
        let bottomOffset: CGFloat = 10
        
        PopoverBackgroundConditioner.shared.insets = UIEdgeInsets.init(top: -topOffset, left: 0, bottom: -bottomOffset, right: -10)
        PopoverBackgroundConditioner.shared.arrowSize = CGSize(width: 25, height: arrowHeight)
        
        let height: CGFloat = UIScreen.main.bounds.height
        let width: CGFloat = UIScreen.main.bounds.width - (sender as! UIButton).frame.maxX - arrowHeight
        
        presentPopoverController(text: "Fullscreen side popover that respects the safe area on iPhone X and iPad pro 3rd generation",
                                 arrowDirection: .left,
                                 color: .lightGray,
                                 popoverSource: sender as! UIButton,
                                 viewSize: CGSize(width: width, height: height))
    }
    
    // Fullscreen side popover that overlaps the safe area on iPhone X and iPad pro 3rd generation
    @IBAction func B2(_ sender: Any) {
        let arrowHeight: CGFloat = 20
        var topOffset: CGFloat = 30
        var bottomOffset: CGFloat = 10
        if #available(iOS 11.0, *) {
            topOffset += view.safeAreaInsets.top
            bottomOffset += view.safeAreaInsets.bottom
        }
        
        PopoverBackgroundConditioner.shared.insets = UIEdgeInsets.init(top: -topOffset, left: 0, bottom: -bottomOffset, right: -10)
        PopoverBackgroundConditioner.shared.arrowSize = CGSize(width: 25, height: arrowHeight)
        
        var height: CGFloat = UIScreen.main.bounds.height
        if #available(iOS 11.0, *) {
            height += view.safeAreaInsets.top + view.safeAreaInsets.bottom
        }
        
        let width: CGFloat = UIScreen.main.bounds.width - (sender as! UIButton).frame.maxX - arrowHeight
        presentPopoverController(text: "Fullscreen side popover that overlaps the safe area on iPhone X and iPad pro 3rd generation",
                                 arrowDirection: .left,
                                 color: .red,
                                 popoverSource: sender as! UIButton,
                                 viewSize: CGSize(width: width, height: height))

    }
    
    // Fullscreen popover with down arrow that respects the safe area on iPhone X and iPad pro 3rd generation
    @IBAction func B3(_ sender: Any) {
        let arrowHeight: CGFloat = 20
        var topOffset: CGFloat = 30 + arrowHeight
        let bottomOffset: CGFloat = 0

        if #available(iOS 11.0, *) {
            topOffset += view.safeAreaInsets.bottom + view.safeAreaInsets.top
        }
        
        PopoverBackgroundConditioner.shared.insets = UIEdgeInsets.init(top: -topOffset, left: -10, bottom: bottomOffset, right: -10)
        PopoverBackgroundConditioner.shared.arrowSize = CGSize(width: 25, height: arrowHeight)
        
        var height: CGFloat = (sender as! UIButton).frame.minY
        if #available(iOS 11.0, *) {
            height -= view.safeAreaInsets.top
        }
        
        presentPopoverController(text: "Fullscreen popover with down arrow that respects the safe area on iPhone X and iPad pro 3rd generation",
                                 arrowDirection: .down,
                                 color: .yellow,
                                 popoverSource: sender as! UIButton,
                                 viewSize: CGSize(width: UIScreen.main.bounds.width, height: height))
    }

    // Fullscreen popover with down arrow that overlaps the safe area on iPhone X and iPad pro 3rd generation
    @IBAction func B4(_ sender: Any) {
        let arrowHeight: CGFloat = 40
        
        var topOffset: CGFloat = 30 + arrowHeight
        let bottomOffset: CGFloat = 0
        if #available(iOS 11.0, *) {
            topOffset += view.safeAreaInsets.bottom + view.safeAreaInsets.top
        }

        PopoverBackgroundConditioner.shared.insets = UIEdgeInsets.init(top: -topOffset, left: -10, bottom: bottomOffset, right: -10)
        PopoverBackgroundConditioner.shared.arrowSize = CGSize(width: 60, height: arrowHeight)
        
        let height: CGFloat = (sender as! UIButton).frame.minY

        presentPopoverController(text: "Fullscreen popover with down arrow that overlaps the safe area on iPhone X and iPad pro 3rd generation",
                                 arrowDirection: .down,
                                 color: .green,
                                 popoverSource: sender as! UIButton,
                                 viewSize: CGSize(width: UIScreen.main.bounds.width, height: height))
    }
    

    func presentPopoverController(text: String,
                                  arrowDirection:UIPopoverArrowDirection,
                                  color: UIColor,
                                  popoverSource: UIView,
                                  viewSize: CGSize) {
        
        self.arrowDirection = arrowDirection
        self.popoverSource = popoverSource
        
        // Set your view controller
        let popVC = textViewController(text: text)
        
        // Set color of arrow and popover vc
        popVC.view.backgroundColor = color
        PopoverBackgroundConditioner.shared.arrowColor = color

        // Set size of content view controller
        popVC.preferredContentSize = viewSize
        
        // Set the presentation style to modal so that the above methods get called.
        popVC.modalPresentationStyle = .popover
        
        // Set the popover presentation controller delegate so that the above methods get called.
        popVC.popoverPresentationController!.delegate = self
        
        // Replaces the stock PopoverBackgroundView
        popVC.popoverPresentationController?.popoverBackgroundViewClass = PopoverBackgroundView.self
        
        // This allows your popover to overlap elements on the screen
        popVC.popoverPresentationController?.canOverlapSourceViewRect = true
        
        // Present the popover.
        self.present(popVC, animated: true, completion: nil)
    }

    //these must be included in your class that implements UIPopoverPresentationControllerDelegate
    var popoverSource : UIView?
    var arrowDirection : UIPopoverArrowDirection = .down

    // Mark: - UIPopoverPresentationControllerDelegate
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.permittedArrowDirections = arrowDirection
        popoverPresentationController.sourceView = popoverSource
        let x: CGFloat = arrowDirection == .down || arrowDirection == .up ? 0 : 10
        let y: CGFloat = arrowDirection == .down || arrowDirection == .up ? 10 : 0
        popoverPresentationController.sourceRect = CGRect(x: x, y: y,
                                                          width: popoverSource!.frame.size.width,
                                                          height: popoverSource!.frame.size.height)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // This *forces* a popover to be displayed on the iPhone
        return .none
    }

    // this is a convenience method to create a view controller to display text for the popover example
    func textViewController(text: String) -> UIViewController {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let popVC: UIViewController = UIViewController()
        popVC.view.addSubview(label)
        
        NSLayoutConstraint(item: label,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: popVC.view,
                           attribute: .centerY,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: label,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: popVC.view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: label,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: popVC.view,
                           attribute: .width,
                           multiplier: 1,
                           constant: -100).isActive = true
        return popVC
    }
}

extension UIView {
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }
    
    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}


