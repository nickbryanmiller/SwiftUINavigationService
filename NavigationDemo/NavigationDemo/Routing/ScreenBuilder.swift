// Builder.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import Combine
import NeedleFoundation
import SwiftUI

// MARK: - ScreenBuilding

/// Root protocol for building screens. Only to be used internally by the routing system
public protocol ScreenBuilding<ScreenParamsType> {
  associatedtype DependencyType
  associatedtype ScreenParamsType: ScreenParams
  associatedtype ViewType: View
  
  /// Dependencies should be lazy so that we only build the dependencies when the page
  /// is about to be presented
  init(dependencies: DependencyType)
  
  /// The screen given the params and a subject (for which the presenter can subscribe)
  func build(
    _ params: ScreenParamsType,
    subject: CurrentValueSubject<ScreenParamsType.DataType, Never>)
  -> ViewType
}

// MARK: - ScreenBuilder

/// A screen builder for pages that do not publish data
public protocol ScreenBuilder: ScreenBuilding
  where
  ScreenParamsType: ScreenParams,
  ScreenParamsType.DataType == Void,
  ViewType: View
{
  associatedtype DependencyType
  associatedtype ScreenParamsType
  associatedtype ViewType
  
  init(dependencies: DependencyType)
  
  func build(_ params: ScreenParamsType) -> ViewType
}

// MARK: - ScreenBuilder + Defaults

/// The default implementations to conform to the root protocol
extension ScreenBuilder {
  public func build(
    _ params: ScreenParamsType,
    subject: CurrentValueSubject<ScreenParamsType.DataType, Never>)
  -> ViewType
  {
    build(params)
  }
}

// MARK: - PublishingScreenBuilder

/// A screen builder for pages that do publish data
public protocol PublishingScreenBuilder: ScreenBuilding
where
ScreenParamsType: ScreenParams,
ViewType: View
{
  associatedtype DependencyType
  associatedtype ScreenParamsType
  associatedtype ViewType
  
  init(dependencies: DependencyType)
}
