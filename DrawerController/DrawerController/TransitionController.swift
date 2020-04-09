//
// Created by Eldis on 2018/5/13.
// Copyright (c) 2018 TH. All rights reserved.
//

import Foundation
import UIKit

public struct Screen {
    /// Retrieves the device bounds.
    public static var bounds: CGRect {
        return UIScreen.main.bounds
    }

    /// Retrieves the device width.
    public static var width: CGFloat {
        return bounds.width
    }

    /// Retrieves the device height.
    public static var height: CGFloat {
        return bounds.height
    }

    /// Retrieves the device scale.
    public static var scale: CGFloat {
        return UIScreen.main.scale
    }
}

open class TransitionController: UIViewController {
    /**
     A Boolean property used to enable and disable interactivity
     with the rootViewController.
     */
    open var isUserInteractionEnabled: Bool {
        get {
            return rootViewController.view.isUserInteractionEnabled
        }
        set(value) {
            rootViewController.view.isUserInteractionEnabled = value
        }
    }

    /// A reference to the container view.
    public let container = UIView()

    /**
     A UIViewController property that references the active
     main UIViewController. To swap the rootViewController, it
     is recommended to use the transitionFromRootViewController
     helper method.
     */
    open internal(set) var rootViewController: UIViewController! {
        willSet {
            guard newValue != rootViewController else {
                return
            }

            guard let v = rootViewController else {
                return
            }

            removeViewController(viewController: v)
        }
        didSet {
            guard oldValue != rootViewController else {
                return
            }

            prepare(viewController: rootViewController, in: container)
        }
    }

    /**
     An initializer that initializes the object with a NSCoder object.
     - Parameter aDecoder: A NSCoder instance.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /**
     An initializer that initializes the object with an Optional nib and bundle.
     - Parameter nibNameOrNil: An Optional String for the nib.
     - Parameter bundle: An Optional NSBundle where the nib is located.
     */
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    /**
     An initializer for the BarController.
     - Parameter rootViewController: The main UIViewController.
     */
    public init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.rootViewController = rootViewController
    }

    open override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootViewController.beginAppearanceTransition(true, animated: animated)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootViewController.endAppearanceTransition()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        rootViewController.beginAppearanceTransition(false, animated: animated)
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        rootViewController.endAppearanceTransition()
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutSubviews()
    }

    /**
     To execute in the order of the layout chain, override this
     method. `layoutSubviews` should be called immediately, unless you
     have a certain need.
     */
    open func layoutSubviews() {}

    /**
     Prepares the view instance when intialized. When subclassing,
     it is recommended to override the prepare method
     to initialize property values and other setup operations.
     The super.prepare method should always be called immediately
     when subclassing.
     */
    open func prepare() {
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.contentScaleFactor = Screen.scale

        prepareContainer()

        guard let v = rootViewController else {
            return
        }

        prepare(viewController: v, in: container)
    }

}

internal extension TransitionController {
    /// Prepares the container view.
    func prepareContainer() {
        container.frame = view.bounds
        container.clipsToBounds = true
        container.contentScaleFactor = Screen.scale
        container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(container)
    }

    /**
     A method that adds the passed in controller as a child of
     the BarController within the passed in
     container view.
     - Parameter viewController: A UIViewController to add as a child.
     - Parameter in container: A UIView that is the parent of the
     passed in controller view within the view hierarchy.
     */
    func prepare(viewController: UIViewController, in container: UIView) {
        addChild(viewController)
        container.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        viewController.view.frame = container.bounds
        viewController.view.clipsToBounds = true
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.contentScaleFactor = Screen.scale
    }
}

internal extension TransitionController {
    /**
     Removes a given view controller from the childViewControllers array.
     - Parameter at index: An Int for the view controller position.
     */
    func removeViewController(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
