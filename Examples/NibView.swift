import UIKit

@IBDesignable
open class NibView: UIView {

    public private(set) var view: UIView!

    override public init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }


    private var nibName: String {
        let className = NSStringFromClass(type(of: self))
        return className.components(separatedBy: ".").last ?? ""
    }


    private func nibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}


//Create a file named MyReusableBoxView.xib and connect outlets to this class

@IBDesignable class MyReusableBoxView: NibView {

    //Custom code, eg member variables with and @IBInspectable's


    override public init(frame: CGRect) {
        super.init(frame: frame)
        //Custom code
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //Custom code
    }

}

