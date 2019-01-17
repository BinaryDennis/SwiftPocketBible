extension UIView {

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static func instantiate(autolayout: Bool = true) -> Self {

        func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
            let view = self.nib.instantiate() as! T
            view.translatesAutoresizingMaskIntoConstraints = !autolayout
            return view
        }

        return instantiateUsingNib(autolayout: autolayout)
    }
}

extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
