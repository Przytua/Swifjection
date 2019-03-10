//
//  Copyright © 2019 Applause Inc. All rights reserved.
//

import UIKit
import Swifjection

class ViewController: UIViewController {
    
    var bar: Bar?
    var singleton: ExampleSingleton?
    var automaticallyInjectableObject: AutoInjectableObject?
    var injectCreatableObject: InjectCreatableObject?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        NSLog("\(String(describing: injector))")
        NSLog("\(String(describing: bar))")
        NSLog("\(String(describing: singleton))")
        NSLog("\(String(describing: automaticallyInjectableObject))")
        NSLog("\(String(describing: injectCreatableObject))")
    }
}

extension ViewController: AutoInjectable {

    var injectableProperties: [InjectableProperty] {
        return [
            requires(\ViewController.bar),
            requires(\ViewController.singleton),
            requires(\ViewController.automaticallyInjectableObject),
            requires(\ViewController.injectCreatableObject)
        ]
    }

}
