/*
Swift extensions allow for great flexibility in adding to the functionality of existing Cocoa classes, 
but similar to Objective-C categories, they don’t allow adding a property to an existing class via an extension.
Using objective-c runtime lib, you can utilize 'associatedObject' to get the same behaviour as a property.
*/
extension UIViewController {

    //static keys inside a private struct dont mess up the global namespace - in contrast to a static var outside the class
    private struct AssociatedKeys {
        static var DescriptiveName = "dc_DescriptiveName"
    }

    var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }

        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.DescriptiveName,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
