// RouterServiceRegistry.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import NeedleFoundation
import SwiftUI

public protocol ScreenBuilderRegistryProtocol {
  func screenBuilder<ScreenParamsType: ScreenParams>(
    _ screenParams: ScreenParamsType)
  -> (any ScreenBuilding<ScreenParamsType>)?
}

public final class ScreenBuilderRegistry: ScreenBuilderRegistryProtocol {
  public init(
    buildClosure: @escaping (any ScreenParams) -> any ScreenBuilding)
  {
    self.buildClosure = buildClosure
  }
  
  public func screenBuilder<ScreenParamsType: ScreenParams>(
    _ screenParams: ScreenParamsType)
  -> (any ScreenBuilding<ScreenParamsType>)? {
    guard
      let builder = buildClosure(screenParams) as? (any ScreenBuilding<ScreenParamsType>)
    else {
      return nil
    }
    
    return builder
  }
  
  private let buildClosure: (any ScreenParams) -> any ScreenBuilding
}

public protocol MissingScreenDependency: Dependency {}

public final class MissingScreenParams: ScreenParams {
  public func screenTransition() -> ScreenTransition { .slideUp }
}

public final class MissingScreenBuilder: ScreenBuilder {
  public init(dependencies: MissingScreenDependency) {}
    
  public func build(_ params: MissingScreenParams) -> some View {
    Text("404, this can be prevented with tooling")
  }
}

public final class VoidScreenParams: ScreenParams {
  public func screenTransition() -> ScreenTransition { .slideUp }
}

public final class VoidScreenBuilder: ScreenBuilder {
  public init(dependencies: Void) {}
    
  public func build(_ params: VoidScreenParams) -> some View {
    Text("404, this should never happen because Needle dependencies are not nil")
  }
}
