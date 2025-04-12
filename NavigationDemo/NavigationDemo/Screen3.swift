// Screen3.swift
//
// Created by Nicholas Miller on 4/12/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import NeedleFoundation
import SwiftUI

// @ScreenParams(.slideUp)
public struct Screen3Params: ScreenParams {}

// @ScreenBuilder(
//   dependencies: [
//     RouterService.self
//   ],
//   params: Screen3Params.self)
public final class Screen3Builder: ScreenBuilder {
  // generated from macro
  private let dependencies: Screen3Dependency
  // generated from macro
  public init(dependencies: Screen3Dependency) {
    self.dependencies = dependencies
  }
  
  public func build(_ params: Screen3Params) -> some View {
    Screen3(routerService: dependencies.routerService)
  }
}

// @Logging(<ScreenName>)
struct Screen3: View {
  var routerService: RouterServiceProtocol
  var body: some View {
    Text("Screen 3")
    Button("Push screen 4") {
      routerService.navigate(Screen4Params())
    }
  }
}

// MARK: Generated Code

// generated from macro on Screen3Builder
public protocol Screen3Dependency: Dependency {
  var routerService: RouterServiceProtocol { get }
}

// generated from macro on Screen3Builder
public final class Screen3Component: Component<Screen3Dependency> {}

extension Screen3Params {
  // Generated from above macro
  public func screenTransition() -> ScreenTransition { .slideUp }
}
