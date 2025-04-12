// ContentView.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import NeedleFoundation
import SwiftUI

struct ContentView: View {
  let routerService: RouterServiceProtocol
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
      Button("Slide up Screen B") {
        routerService.navigate(ScreenBParams())
      }
      Button("Slide up screen 3") {
        routerService.navigate(Screen3Params())
      }
      Button("Push screen 4") {
        routerService.navigate(Screen4Params())
      }
    }
    .padding()
  }
}


public protocol AppComponentDependency: Dependency {
  var routerService: RouterServiceProtocol { get }
}

public final class AppComponent: Component<AppComponentDependency>,
ScreenBDependency,
Screen3Dependency,
Screen4Dependency,
MissingScreenDependency
{
  public var screenBService: ScreenBService {
    DefaultScreenBService()
  }
  
  public var routerService: RouterServiceProtocol {
    dependency.routerService
  }
}
