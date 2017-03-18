extension UIViewController {

    /*
    There are two methods that are automatically invoked by the Objective-C runtime for each class. 
    +load() is sent when the class is initially loaded, while +initialize() is called just before the application 
    calls its first method on that class or an instance of that class. Both are optional, and are executed only 
    if the method is implemented.
    Because method swizzling affects global state, it is important to minimize the possibility of race conditions. 
    +load is guaranteed to be loaded during class initialization, which provides a modicum of consistency for 
    changing system-wide behavior. By contrast, +initialize provides no such guarantee of when it will be 
    executed—in fact, it may never be called, if that class is never messaged directly by the app.
    
    Unfortunately, a load class method implemented in Swift is never called by the runtime. 
    Swizzling using the +initialize() method CAN be done safely, as long as you check the type at execution time and 
    wrap the swizzling in dispatch_once.
    */
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }

        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }

        /*
        Swizzling should always be done in a dispatch_once, since GCD’s dispatch_once provides both atomicity (i.e. all or nothing)
        and guarantee that code will be executed exactly once, even across different threads.
        */
        dispatch_once(&Static.token) {
            let originalSelector = Selector("viewWillAppear:")
            let swizzledSelector = Selector("nsh_viewWillAppear:")

            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)

            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }

    // MARK: - Method Swizzling

    func nsh_viewWillAppear(animated: Bool) {
        self.nsh_viewWillAppear(animated). //will call the original viewWillAppear(:) method which is at this point swizzled 
        
        // Do whaterver ...
    }
}