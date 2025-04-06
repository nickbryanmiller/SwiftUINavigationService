// RouterService.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import Combine
import SwiftUI

public final class RouterService: RouterServiceProtocol {
  
  init(
    screenBuilderRegistry: ScreenBuilderRegistryProtocol)
  {
    self.screenBuilderRegistry = screenBuilderRegistry
  }
  
  public func navigate<ScreenParamsType: ScreenParams>(
    _ screenParams: ScreenParamsType)
  -> NavigationResult<ScreenParamsType>
  {
    let subject = CurrentValueSubject<ScreenParamsType.DataType, Never>(ScreenParamsType.initialData)
    
    guard
      let screenBuilder = screenBuilderRegistry.screenBuilder(screenParams)
    else {
      return .init(
        dismissable: AnyDismissable(EmptyView()),
        publisher: subject.eraseToAnyPublisher())
    }
    
    let view = screenBuilder.build(
      screenParams,
      subject: subject)
    
    return .init(
      dismissable: AnyDismissable(view),
      publisher: subject.eraseToAnyPublisher())
  }
  
  // MARK: Private
  
  private let screenBuilderRegistry: ScreenBuilderRegistryProtocol
}
