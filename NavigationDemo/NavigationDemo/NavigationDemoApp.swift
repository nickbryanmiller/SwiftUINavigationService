// NavigationDemoApp.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import NeedleFoundation
import SwiftUI

@main
struct NavigationDemoApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

final class RootComponent: BootstrapComponent {
  var appComponent: AppComponent {
    return AppComponent(parent: self)
  }
}

let rootComponent = RootComponent()
