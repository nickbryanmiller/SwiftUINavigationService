// ScreenB.swift
//
// Created by Nicholas Miller on 4/12/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import NeedleFoundation
import SwiftUI

public protocol ScreenBService {
  func foo()
}

public final class DefaultScreenBService: ScreenBService {
  public func foo() {
    print("foo")
  }
}

// We can make a macro for this which generate ScreenBComponent to make it even simpler
// It would generate ScreenBComponent
public protocol ScreenBDependency: Dependency {
  var screenBService: ScreenBService { get }
}

public final class ScreenBComponent: Component<ScreenBDependency> {}

// We can make a macro for this which will compiler fail if it is not a struct.
// It would also conform it to ScreenParams if we want to be more declarative in syntax
// @ScreenParams(.slideUp)
public struct ScreenBParams: ScreenParams {
  public func screenTransition() -> ScreenTransition { .slideUp }
}

public final class ScreenBBuilder: ScreenBuilder {
  private let dependencies: ScreenBDependency
  
  public init(dependencies: ScreenBDependency) {
    self.dependencies = dependencies
  }
  
  public func build(_ params: ScreenBParams) -> some View {
    ScreenB(service: dependencies.screenBService)
  }
}

// We declare macros here to remove infra from our body
// @Logging(<ScreenName>)
struct ScreenB: View {
  let service: ScreenBService
  var body: some View {
    Text("yayyy")
  }
}
