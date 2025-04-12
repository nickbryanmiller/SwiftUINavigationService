// NavigationDemoApp.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import NeedleFoundation
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
  -> Bool
  {
    true
  }
}

var rootComponent: RootComponent = {
  registerProviderFactories()
  return RootComponent()
}()

@main
struct NavigationDemoApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      rootComponent.rootView
    }
  }
}

public final class RootComponent: BootstrapComponent {
  
  public var rootView: some View {
    NavigationRootView(routerService: mutableRouterService) {
      ContentView(routerService: routerService)
    }
  }
  
  public var appComponent: AppComponent {
    AppComponent(parent: self)
  }
  
  public var routerService: RouterServiceProtocol {
    mutableRouterService
  }
  
  public var mutableRouterService: MutableRouterServiceProtocol {
    guard let exisitingRouterService = exisitingRouterService else {
      let createdRouterService = RouterService(screenBuilderRegistry: screenBuilderegistry)
      exisitingRouterService = createdRouterService
      return createdRouterService
    }
    
    return exisitingRouterService
  }
  
  public weak var exisitingRouterService: MutableRouterServiceProtocol?
}

// MARK: Generated

extension RootComponent {
  // Ideally this is generated code
  public var screenBuilderegistry: ScreenBuilderRegistry {
    return ScreenBuilderRegistry { [appComponent] screenParams in
      let identifier = screenParams.identifier
      
      switch identifier {
      case ScreenBParams.identifier:
        return ScreenBBuilder(dependencies: appComponent)
      case Screen3Params.identifier:
        return Screen3Builder(dependencies: appComponent)
      case Screen4Params.identifier:
        return Screen4Builder(dependencies: appComponent)
      default:
        return MissingScreenBuilder(dependencies: appComponent)
      }
    }
  }
}
