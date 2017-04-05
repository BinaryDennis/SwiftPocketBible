extension UIView {
    public func getSnapshotImage(withBackgroundColor bgColor: CGColor = UIColor.white.cgColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(bgColor)
            context.fill(self.bounds)
        }
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImage
    }
}
