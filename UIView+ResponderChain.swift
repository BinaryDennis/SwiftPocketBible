import UIKit

extension UIView {
    
    /// Attempts to resign first responder status and asks the previous sibling responder to become first responder
    func focusPreviousSiblingResponder() {
        if resignFirstResponder() {
            previousSiblingResponder()?.becomeFirstResponder()
        }
    }
    
    /// Attempts to resign first responder status and asks the next sibling responder to become first responder
    func focusNextSiblingResponder() {
        if resignFirstResponder() {
            nextSiblingResponder()?.becomeFirstResponder()
        }
    }
    
    /// Returns the sibling UIResponder before 'self', or nil if no previous sibling responder exists
    func previousSiblingResponder() -> UIResponder? {
        guard let siblings = superview?.subviews,
            let selfIndex = siblings.index(of: self) else {
                return nil
        }
        let previousResponders = siblings.prefix(upTo: selfIndex).filter { $0.canBecomeFirstResponder }
        return previousResponders.reversed().first
    }
    
    /// Returns the sibling UIResponder after 'self', or nil if no next sibling responder exists
    func nextSiblingResponder() -> UIResponder? {
        guard let siblings = superview?.subviews,
            let selfIndex = siblings.index(of: self), selfIndex != siblings.index(before: siblings.endIndex) else {
                return nil
        }
        
        let nextResponders = siblings.suffix(from: siblings.index(after: selfIndex)).filter { $0.canBecomeFirstResponder }
        return nextResponders.first
    }
}
