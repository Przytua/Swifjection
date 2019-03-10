//
//  Copyright © 2019 Applause Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

private var AssociatedInjectorHandle: UInt8 = 0

public extension Injectable where Self: UIViewController {

    public var injector: Injecting? {
        get {
            return objc_getAssociatedObject(self, &AssociatedInjectorHandle) as? Injecting
        }
        set {
            objc_setAssociatedObject(self, &AssociatedInjectorHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }

    public func injectDependencies(injector: Injecting) {
        var viewController = self as UIViewController & Injectable
        viewController.injector = injector
        if let autoinjectableSelf = self as? AutoInjectable {
            autoinjectableSelf.autoinjectDependencies(injector: injector)
        }
    }
}

extension UITabBarController: Injectable {

    public var injector: Injecting? {
        get {
            return objc_getAssociatedObject(self, &AssociatedInjectorHandle) as? Injecting
        }
        set {
            objc_setAssociatedObject(self, &AssociatedInjectorHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }

    public func injectDependencies(injector: Injecting) {
        self.injector = injector
        guard let viewControllers = viewControllers else {
            return
        }
        for viewController in viewControllers {
            if let injectable = viewController as? Injectable {
                injectable.injectDependencies(injector: injector)
            }
        }
        if let autoinjectableSelf = self as? AutoInjectable {
            autoinjectableSelf.autoinjectDependencies(injector: injector)
        }
    }

}

extension UINavigationController: Injectable {

    public var injector: Injecting? {
        get {
            return objc_getAssociatedObject(self, &AssociatedInjectorHandle) as? Injecting
        }
        set {
            objc_setAssociatedObject(self, &AssociatedInjectorHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }

    public func injectDependencies(injector: Injecting) {
        self.injector = injector
        for viewController in self.viewControllers {
            if let viewController = viewController as? Injectable {
                viewController.injectDependencies(injector: injector)
            }
        }
        if let autoinjectableSelf = self as? AutoInjectable {
            autoinjectableSelf.autoinjectDependencies(injector: injector)
        }
    }

}

extension UISplitViewController: Injectable {

    public var injector: Injecting? {
        get {
            return objc_getAssociatedObject(self, &AssociatedInjectorHandle) as? Injecting
        }
        set {
            objc_setAssociatedObject(self, &AssociatedInjectorHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }

    public func injectDependencies(injector: Injecting) {
        self.injector = injector
        for viewController in self.viewControllers {
            if let viewController = viewController as? Injectable {
                viewController.injectDependencies(injector: injector)
            }
        }
        if let autoinjectableSelf = self as? AutoInjectable {
            autoinjectableSelf.autoinjectDependencies(injector: injector)
        }
    }

}
