// ScreenParams.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

public protocol ScreenParams {
  associatedtype DataType = Void
  
  func screenTransition() -> ScreenTransition
  static var initialData: DataType { get }
}

extension ScreenParams {
  public static var identifier: ObjectIdentifier {
    ObjectIdentifier(Self.self)
  }
  
  public var identifier: ObjectIdentifier {
    Self.identifier
  }
}

extension ScreenParams where DataType == Void {
  public static var initialData: DataType {
    ()
  }
}
