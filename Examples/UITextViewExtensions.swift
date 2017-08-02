//Remove all margin/padding in a UITextView

extension UITextView {
    public func clearInsetAndPadding() {
        self.textContainerInset = UIEdgeInsets.zero
        self.textContainer.lineFragmentPadding = 0
    }
}
