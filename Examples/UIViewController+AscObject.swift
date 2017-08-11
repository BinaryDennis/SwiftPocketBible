/*
Swift extensions allow for great flexibility in adding to the functionality of existing Cocoa classes, 
but similar to Objective-C categories, they don’t allow adding a property to an existing class via an extension.
Using objective-c runtime lib, you can utilize 'associatedObject' to get the same behaviour as a property.
*/


// Alternative A (if extension extends a subclass of NSObject)
extension UIViewController {

    // Declare static vars to produce unique addresses as the associate objects handlers
    private struct AssociatedKeys { 
        static var DescriptiveName = "dummy"
        static var OtherDescriptiveName = "dummy"
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


// Alternative B (if extension DOES NOT extends a subclass of NSObject)

var MyStructAssociateKeyForDescriptiveName : String = "dummy"     // Declare global vars to produce unique addresses as the associate objects handlers
extension MyStruct {

    var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &MyStructAssociateKeyForDescriptiveName) as? String
        }

        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &MyStructAssociateKeyForDescriptiveName,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}
