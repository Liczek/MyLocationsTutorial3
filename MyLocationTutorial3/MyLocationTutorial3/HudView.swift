//
//  HudView.swift
//  MyLocationTutorial3
//
//  Created by Paweł Liczmański on 10.03.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit

class HudView: UIView {
    
    var text = ""
//MARK: - Adding new view
    class func hud(inView view: UIView, animated: Bool) -> HudView {
        let hudView = HudView(frame: view.bounds)
        hudView.isOpaque = false
        
        view.addSubview(hudView)
        view.isUserInteractionEnabled = false
        
        hudView.show(animated: animated)
        return hudView
    }
//MARK: - HUD localisation, size, and fill by color
    override func draw(_ rect: CGRect) {
        //size
        let boxWidth: CGFloat = 96
        let boxHeight: CGFloat = 96
        //position
        let boxRect = CGRect(x: round((bounds.size.width - boxWidth) / 2), y: round((bounds.size.height - boxHeight) / 2), width: boxWidth, height: boxHeight)
        //rounded corners
        let roundedRect = UIBezierPath(roundedRect: boxRect, cornerRadius: 10)
        //color
        UIColor(white: 0.3, alpha: 0.8).setFill()
        roundedRect.fill()
        
//MARK: - HUD Adding image and text
        
        //image
        if let image = UIImage(named: "Checkmark") {
            let imagePoint = CGPoint(x: center.x - round(image.size.width / 2), y: center.y - round(image.size.height / 2) - boxHeight / 8)
            image.draw(at: imagePoint)
        }
        
        //text
        let attribs = [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.white]
        
        let textSize = text.size(attributes: attribs)
        
        let textPoint = CGPoint(x: center.x - round(textSize.width / 2), y: center.y - round(textSize.height / 2) + boxHeight / 4)
        
        text.draw(at: textPoint, withAttributes: attribs)
    }
    
//MARK: - Animations
    
    func show(animated: Bool) {
        if animated {
            alpha = 0
            transform = CGAffineTransform(scaleX: 3, y: 3)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                self.alpha = 1
                self.transform = CGAffineTransform.identity} ,
                completion: nil)
            
//            UIView.animate(withDuration: 0.3, animations: {
//                self.alpha = 1
//                self.transform = CGAffineTransform.identity })
        }
    }
    
}
