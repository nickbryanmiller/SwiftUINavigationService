// RouterServiceProtocol.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import Combine
import SwiftUI

public protocol Dismissable {
  func dismiss()
}

public final class AnyDismissable: Dismissable {
  init<ViewType: View>(
    _ view: ViewType)
  {}
  
  public func dismiss() {
    
  }
}

public struct NavigationResult<ScreenParamsType: ScreenParams> {
  let dismissable: Dismissable
  let publisher: AnyPublisher<ScreenParamsType.DataType, Never>  
}

public protocol RouterServiceProtocol {
  @discardableResult
  func navigate<ScreenParamsType: ScreenParams>(
    _ screenParams: ScreenParamsType)
  -> NavigationResult<ScreenParamsType>
}

extension RouterServiceProtocol {
  @discardableResult
  func navigate<ScreenParamsType: ScreenParams>(
    _ screenParams: ScreenParamsType)
  -> Dismissable
  {
    navigate(screenParams).dismissable
  }
}
