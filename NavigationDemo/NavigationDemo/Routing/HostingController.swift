// HostingController.swift
//
// Created by Nicholas Miller on 4/9/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import UIKit
import SwiftUI

public final class NavigationLifecycleHooks {
  public enum DismissType {
    case modal(UIViewController)
    case pop(container: UIViewController, child: UIViewController?)
  }
  public let onDismiss: ((DismissType) -> Void)?
  
  init(onDismiss: ((DismissType) -> Void)? = nil) {
    self.onDismiss = onDismiss
  }
}

public final class HostingController<Content: View>: UIHostingController<Content> {}

public final class NavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
  private let navigationLifecycleHooks: NavigationLifecycleHooks
  
  required public init(
    rootViewController: UIViewController,
    navigationLifecycleHooks: NavigationLifecycleHooks)
  {
    self.navigationLifecycleHooks = navigationLifecycleHooks
    super.init(rootViewController: rootViewController)
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidDisappear(_ animated: Bool) {
    if super.isBeingDismissed {
      navigationLifecycleHooks.onDismiss?(.modal(self))
    }
    
    super.viewDidDisappear(animated)
  }
  
  public override func popViewController(animated: Bool) -> UIViewController? {
    let vc = super.popViewController(animated: animated)
    
    if super.isBeingDismissed {
      navigationLifecycleHooks.onDismiss?(.pop(container: self, child: vc))
    }
    
    return vc
  }
  
  public override func present(
    _ viewControllerToPresent: UIViewController,
    animated flag: Bool,
    completion: (() -> Void)? = nil)
  {
    viewControllerToPresent.transitioningDelegate = self
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
  
  public override func show(_ vc: UIViewController, sender: Any?) {
    vc.transitioningDelegate = self
    super.show(vc, sender: sender)
  }
  
  public func animationController(
    forDismissed dismissed: UIViewController)
  -> (any UIViewControllerAnimatedTransitioning)?
  {
    print(super.isBeingDismissed)
    return nil
  }
}

struct NavigationRootView: UIViewControllerRepresentable {
  
  init<ViewType: View>(
    routerService: MutableRouterServiceProtocol,
    _ view: () -> ViewType)
  {
    navigationController = routerService.load(view())
  }
    
  func makeUIViewController(context: Context) -> UIViewController {
    navigationController
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
  
  @State private var navigationController: UIViewController
}
