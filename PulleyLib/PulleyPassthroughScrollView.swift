//
//  PulleyPassthroughScrollView.swift
//  Pulley
//
//  Created by Brendan Lee on 7/6/16.
//  Copyright © 2016 52inc. All rights reserved.
//

import UIKit

protocol PulleyPassthroughScrollViewDelegate: class {
    
    func shouldTouchPassthroughScrollView(scrollView: PulleyPassthroughScrollView, point: CGPoint) -> Bool
    func viewToReceiveTouch(scrollView: PulleyPassthroughScrollView) -> UIView
}

class PulleyPassthroughScrollView: UIScrollView {
    
    weak var touchDelegate: PulleyPassthroughScrollViewDelegate?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if let touchDel = touchDelegate
        {
            if touchDel.shouldTouchPassthroughScrollView(scrollView: self, point: point)
            {
				let x = touchDel.viewToReceiveTouch(scrollView: self)
				if #available(iOS 8.0, *) {
					let t = x.convert(point, from: self)
					return touchDel.viewToReceiveTouch(scrollView: self).hitTest(t, with: event)
				} else {
					// Fallback on earlier versions
					print("FAZER BRIDGE OBJC")
					return super.hitTest(point, with: event)
				}
				
            }
        }
        
        return super.hitTest(point, with: event)
    }
}
