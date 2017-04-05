extension UIImage {

     class func imageFrom(color: UIColor, size: CGSize = CGSize(width: 1, height: 1) ) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: size)

        UIGraphicsBeginImageContext(rect.size)
        defer {
            UIGraphicsEndImageContext()
        }

        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }

        return UIGraphicsGetImageFromCurrentImageContext()!
    }

}
