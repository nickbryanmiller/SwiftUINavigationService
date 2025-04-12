// RouterServiceProtocol.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import Combine
import UIKit
import SwiftUI

public protocol Dismissable {
  func dismiss()
}

public final class AnyDismissable: Dismissable {
  init(_ viewController: UIViewController) {
    self.viewController = viewController
  }
  
  public func dismiss() {
    viewController.dismiss(animated: true)
  }
  
  // MARK: Private
  
  private let viewController: UIViewController
}

public struct NavigationResult<ScreenParamsType: ScreenParams> {
  let dismissable: Dismissable
  let publisher: AnyPublisher<ScreenParamsType.DataType, Never>  
}

public protocol MutableRouterServiceProtocol: AnyObject, RouterServiceProtocol {
  func load<ViewType: View>(_ view: ViewType) -> UIViewController
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
