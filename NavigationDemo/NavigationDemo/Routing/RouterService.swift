// RouterService.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import Combine
import SwiftUI

public final class RouterService: MutableRouterServiceProtocol {
  
  // MARK: Lifecycle
  
  init(
    screenBuilderRegistry: ScreenBuilderRegistryProtocol)
  {
    self.screenBuilderRegistry = screenBuilderRegistry
  }
  
  // MARK: Public
  
  public func load<ViewType: View>(_ view: ViewType) -> UIViewController {
    let screen = ScreenRoot(
      view: view,
      screenParams: RootScreenParams(),
      navigationLifecycleHooks: .init())
    screenHierarchy = [screen]
    return screen.navigationController
  }
  
  public func navigate<ScreenParamsType: ScreenParams>(
    _ screenParams: ScreenParamsType)
  -> NavigationResult<ScreenParamsType>
  {
    let subject = CurrentValueSubject<ScreenParamsType.DataType, Never>(ScreenParamsType.initialData)
    
    guard
      let screenBuilder = screenBuilderRegistry.screenBuilder(screenParams)
    else {
      // Ideally you would have a fun 404 page (that should never be seen)
      // and alarms going off
      return .init(
        dismissable: AnyDismissable(UIViewController()),
        publisher: subject.eraseToAnyPublisher())
    }
    
    let view = screenBuilder.build(
      screenParams,
      subject: subject)
    
    let dismissable = show(
      view: view,
      screenParams: screenParams)
    
    return .init(
      dismissable: dismissable,
      publisher: subject.eraseToAnyPublisher())
  }
  
  // MARK: Private
  
  private let screenBuilderRegistry: ScreenBuilderRegistryProtocol
  private var screenHierarchy: [ScreenRoot] = []
  
  private lazy var navigationLifecycleHooks: NavigationLifecycleHooks = {
    NavigationLifecycleHooks(
      onDismiss: { [weak self] dismissType in
        switch dismissType {
        case .modal(let vc):
          self?.screenHierarchy.removeAll(where: { $0.navigationController == vc })
        case .pop(let container, let child):
          let foundContainer = self?.screenHierarchy.first(where: { $0.navigationController == container })
          foundContainer?.screens.removeAll(where: { $0.viewController == child })
        }
      })
  }()
  
  @discardableResult
  private func show<ViewType: View>(
    view: ViewType,
    screenParams: any ScreenParams)
  -> Dismissable
  {
    let presenter: ScreenRoot
    if let lastScreen = screenHierarchy.last {
      presenter = lastScreen
    } else {
      presenter = ScreenRoot(
        view: view,
        screenParams: screenParams,
        navigationLifecycleHooks: navigationLifecycleHooks)
      screenHierarchy = [presenter]
    }
    
    switch screenParams.screenTransition() {
    case .push(let isInContext):
      if isInContext {
        let screen = Screen(view: view, screenParams: screenParams)
        presenter.push(screen: screen)
        return presenter.rootScreen.dismissable
      } else {
        let screen = ScreenRoot(
          view: view,
          screenParams: screenParams,
          navigationLifecycleHooks: navigationLifecycleHooks)
        presenter.show(screen: screen)
        screenHierarchy.append(screen)
        return presenter.rootScreen.dismissable
      }
    case .slideUp:
      let screen = ScreenRoot(
        view: view,
        screenParams: screenParams,
        navigationLifecycleHooks: navigationLifecycleHooks)
      presenter.show(screen: screen)
      screenHierarchy.append(screen)
      return presenter.rootScreen.dismissable
    }
  }
}

// MARK: Private

private final class ScreenRoot {
  
  convenience init<ViewType: View>(
    view: ViewType,
    screenParams: any ScreenParams,
    navigationLifecycleHooks: NavigationLifecycleHooks)
  {
    self.init(
      navigationController: NavigationController(
        rootViewController: HostingController(rootView: view),
        navigationLifecycleHooks: navigationLifecycleHooks),
      screenParams: screenParams)
  }
  
  private init(
    navigationController: NavigationController,
    screenParams: any ScreenParams)
  {
    rootScreen = Screen(
      navigationController: navigationController,
      screenParams: screenParams)
    
    self.navigationController = navigationController
    
    screens = [rootScreen]
  }
  
  let rootScreen: Screen
  var screens: [Screen]
  let navigationController: NavigationController
  
  func push(screen: Screen) {
    screens.append(screen)
    navigationController.pushViewController(screen.viewController, animated: true)
  }
  
  func show(screen: ScreenRoot) {
    rootScreen.viewController.present(screen.navigationController, animated: true)
  }
}

struct RootScreenParams: ScreenParams {
  // This does not matter
  public func screenTransition() -> ScreenTransition { .push(isInContext: true) }
}

private final class Screen {
  convenience init<ViewType: View>(
    view: ViewType,
    screenParams: any ScreenParams)
  {
    self.init(
      viewController: HostingController(rootView: view),
      screenParams: screenParams)
  }
  
  convenience init(
    navigationController: NavigationController,
    screenParams: any ScreenParams)
  {
    self.init(
      viewController: navigationController,
      screenParams: screenParams)
  }
  
  private init(
    viewController: UIViewController,
    screenParams: any ScreenParams)
  {
    self.screenParams = screenParams
    self.viewController = viewController
    dismissable = AnyDismissable(viewController)
  }
  
  let viewController: UIViewController
  let screenParams: any ScreenParams
  let dismissable: Dismissable
}
