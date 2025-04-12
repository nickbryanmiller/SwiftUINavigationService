// Screen4.swift
//
// Created by Nicholas Miller on 4/12/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import NeedleFoundation
import SwiftUI

// @ScreenParams(.push(inContext: true))
public struct Screen4Params: ScreenParams {}

// @ScreenBuilder(
//   dependencies: [],
//   params: Screen3Params.self)
public final class Screen4Builder: ScreenBuilder {
  // generated from macro
  private let dependencies: Screen4Dependency
  // generated from macro
  public init(dependencies: Screen4Dependency) {
    self.dependencies = dependencies
  }
  
  public func build(_ params: Screen4Params) -> some View {
    Screen4()
  }
}

// @Logging(<ScreenName>)
struct Screen4: View {
  var body: some View {
    Text("Screen 4")
  }
}

// MARK: Generated Code

// generated from macro on Screen4Builder
public protocol Screen4Dependency: Dependency {
}

// generated from macro on Screen4Builder
public final class Screen4Component: Component<Screen4Dependency> {}

extension Screen4Params {
  // Generated from above macro
  public func screenTransition() -> ScreenTransition { .push(isInContext: true) }
}

