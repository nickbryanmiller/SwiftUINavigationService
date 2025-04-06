// ScreenParams.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

public protocol ScreenParams {
  associatedtype DataType = Void
  
  var screenTransition: ScreenTransition { get }
  static var initialData: DataType { get }
}

extension ScreenParams {
  public var identifier: ObjectIdentifier {
    ObjectIdentifier(Self.self)
  }
}

extension ScreenParams where DataType == Void {
  public static var initialData: DataType {
    ()
  }
}
