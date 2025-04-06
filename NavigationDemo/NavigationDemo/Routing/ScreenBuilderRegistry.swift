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

public final class ScreenBuilderRegistry<DependencyType: Dependency>: ScreenBuilderRegistryProtocol {
  public init(
    dependency: DependencyType,
    buildClosure: @escaping (DependencyType, any ScreenParams) -> some ScreenBuilding)
  {
    self.dependency = dependency
    self.buildClosure = buildClosure
  }
  
  public func screenBuilder<ScreenParamsType: ScreenParams>(
    _ screenParams: ScreenParamsType)
  -> (any ScreenBuilding<ScreenParamsType>)? {
    guard
      let builder = buildClosure(dependency, screenParams) as? (any ScreenBuilding<ScreenParamsType>)
    else {
      return nil
    }
    
    return builder
  }
  
  private let dependency: DependencyType
  private let buildClosure: (DependencyType, any ScreenParams) -> any ScreenBuilding
}

public final class MissingScreenDependency: Dependency {}
public final class MissingScreenParams: ScreenParams {
  public var screenTransition: ScreenTransition = .slideUp
}

public final class MissingScreenBuilder: ScreenBuilder {
  public init(dependencies: MissingScreenDependency) {}
  
  public typealias DependecyType = MissingScreenDependency
  public typealias ScreenParamsType = MissingScreenParams
//  typealias ScreenType = Text
  
  public func build(_ params: ScreenParamsType) -> any View {
    Text("404, this should never happen")
  }
  
}
