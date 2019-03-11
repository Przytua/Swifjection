# Swifjection Changelog

## [0.8.1] - 10.03.2019
### Added
* Common extensions of View Controllers (`UIViewController`, `UITabBarController`, `UINavigationController` and `UISplitViewController`), for easy, propagated injection from App Delegate:

  ```Swift
  if let injector = self.injector, let rootViewController = window?.rootViewController as? Injectable {
      rootViewController.injectDependencies(injector: injector)
  }
  ```

## [0.8.0] - 06.03.2019
### Added
* Automatic injection with `AutoInjectable` protocol using:

  ```Swift
  class MyClass: AutoInjectable {

    var property1: MyOtherClass!
    var property2: MyOtherClass!

    var injectableProperties: [InjectableProperty] {
      return [
          requires(\MyClass.property1),
          requires(\MyClass.property2)
      ]
    }

  }
  ```

### Changed:
* Updated to Swift 4.2
* Separated initialization from `Injectable` protocol by adding `Creatable` and `InjectCreatable` protocols with `init()` and `init(injector: Injecting)` respectively

## [0.7.0] - 10.04.2017
### Added
* Subscript implementation for injecting objects using:

  ```Swift
  let myObject = injector[MyClass.self]
  let myOhterObject: MyClass? = injector[MyClass.self] as MyClass // This requires explicit casting
  ```

### Fixed:
* fixes issue with implicitly unwrapped optional used for object bindings in Swift 3.1 (Xcode 8.3.x); now the object bindings defines the property type `Any?`

## [0.6.0] - 26.01.2017
### Added:
* Continuous Integration setup with build status badge in README
* Code documentation
* Swift Package manifest
* `CHANGELOG`

### Changed:
* Resolved exception when `Swifjection` couldn't create instance of singleton object
* Changed order of closure binding function parameters:

  ```Swift
  func bind(closure: @escaping ((Injecting) -> Any), toType type: Any.Type)
  ```

  was renamed to

  ```Swift
  func bind(type: Any.Type, with closure: @escaping ((Injecting) -> Any))
  ```

  This allows to omit argument name and have closure defined after closing parenthesis. Instead of:

  ```Swift
  bindings.bind(closure: { (injector: Injecting) -> AnyObject in
    return SomeClass()
  }, toType: SomeClass.self)
  ```

  you can use:

  ```Swift
  bindings.bind(type: SomeClass.self) { (injector: Injecting) -> AnyObject in
    return SomeClass()
  }
  ```

## [0.5.0] - 18.01.2017 (Public release)
### Added:
* README with framework descripton and examples
* CONTRIBUTION document

## [0.4.1] - 22.12.2016
### Added:
* Updated object binding to allow binding struct objects

## [0.4.0] - 10.11.2016
### Added:
* Type to type binding
* Singleton binding

### Changed:
* Added bindings container object, conforming to `Binding` protocol, instead of keeping instances, or closures assigned directly to type

### Fixed:
* Changed bind functions `toType` parameter type from `Any` to `Any.Type`

## [0.3.1] - 28.10.2016
### Fixed:
* Bindings properties and functions access control

## [0.3.0] - 28.10.2016
### Added:
* `Swifjector` class implementing `Injecting` protocol

### Changed:
* Extracted binding from `Injecting` protocol to separate  `Bindings` class

## [0.2.0] - 28.10.2016 (First internal release)
### Added:
* Injectable protocol, and extension with default implementation of ```injectDependencies(injector: Injecting)``` function
* Injecting protocol, and extensions with default implementations of binding functions and creating dependencies functions
  - Object binding
  - Closure binding

[Unreleased]: https://github.com/ApplauseOSS/Swifjection/compare/0.6.0...HEAD
[0.6.0]: https://github.com/ApplauseOSS/Swifjection/compare/0.5.1...0.6.0
[0.5.0]: https://github.com/ApplauseOSS/Swifjection/compare/v0.4.1...0.5.0
[0.4.1]: https://github.com/ApplauseOSS/Swifjection/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/ApplauseOSS/Swifjection/compare/v0.3.1...v0.4.0
[0.3.1]: https://github.com/ApplauseOSS/Swifjection/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/ApplauseOSS/Swifjection/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/ApplauseOSS/Swifjection/tree/v0.2.0
