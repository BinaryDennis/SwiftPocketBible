import UIKit

extension NSLayoutConstraint {
    
    class func fit(view: UIView, with secondView: UIView, top: CGFloat? = 0,
             leading: CGFloat? = 0, trailing: CGFloat? = 0,
             bottom: CGFloat? = 0  ) {
        
        if let top = top {
            NSLayoutConstraint(item: view, attribute:.top, relatedBy:.equal, toItem: secondView,
                               attribute:.top, multiplier: 1, constant: top).isActive = true
        }
        
        if let leading = leading {
            NSLayoutConstraint(item: view, attribute:.leading, relatedBy:.equal, toItem: secondView,
                               attribute:.leading, multiplier: 1, constant: leading).isActive = true
        }
        
        if let trailing = trailing {
            NSLayoutConstraint(item: view, attribute:.trailing, relatedBy:.equal, toItem: secondView,
                               attribute:.trailing, multiplier: 1, constant: trailing).isActive = true
        }
        
        if let bottom = bottom {
            NSLayoutConstraint(item: view, attribute:.bottom, relatedBy:.equal, toItem: secondView,
                               attribute:.bottom, multiplier: 1, constant: bottom).isActive = true
        }
        
    }
    
    class func center(view: UIView, with secondView: UIView, centerX: CGFloat? = 0, centerY: CGFloat? = 0) {
        
        if let centerX = centerX {
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: secondView,
                               attribute: .centerX, multiplier: 1, constant: centerX).isActive = true
        }
        
        if let centerY = centerY {
            NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: secondView,
                               attribute: .centerY, multiplier: 1, constant: centerY).isActive = true
        }
    }
    
    class func setHeight(_ height: CGFloat, to view: UIView, relatedBy: NSLayoutRelation = .equal) {
        NSLayoutConstraint(item: view, attribute: .height, relatedBy: relatedBy, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height).isActive = true
    }
    
    class func setWidth(_ width: CGFloat, to view: UIView, relatedBy: NSLayoutRelation = .equal) {
        NSLayoutConstraint(item: view, attribute: .width, relatedBy: relatedBy, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width).isActive = true
    }
    
}
