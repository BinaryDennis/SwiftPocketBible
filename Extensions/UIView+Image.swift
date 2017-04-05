extension UIView {
    public func getSnapshotImage(withBackgroundColor bgColor: CGColor = UIColor.white.cgColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.setFillColor(bgColor)
            ctx.fill(self.bounds)
        }
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImage
    }
}
