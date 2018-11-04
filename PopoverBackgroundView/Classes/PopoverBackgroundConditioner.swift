//
//  PopoverBackgroundConditioner.swift
//  Pods
//
//  Created by Jason Wolkovitz on 11/3/18.
//

import UIKit

public class PopoverBackgroundConditioner {
    public static let shared = PopoverBackgroundConditioner()
    public weak var currentBackground : PopoverBackgroundView?
    public var arrowColor : UIColor = .clear
    public var insets : UIEdgeInsets = UIEdgeInsets(top: -30, left: -10, bottom: -10, right: -10)
    public var arrowSize : CGSize = CGSize(width: 20, height: 10)
}
