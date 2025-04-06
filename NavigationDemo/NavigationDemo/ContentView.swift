// ContentView.swift
//
// Created by Nicholas Miller on 4/6/25.
// Copyright © 2025 Nicholas Miller. All rights reserved.

import NeedleFoundation
import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
  }
}

#Preview {
  ContentView()
}

typealias AppComponentDependency = MissingScreenDependency

final class AppComponent: Component<AppComponentDependency> {
  var screenBuilderegistry: ScreenBuilderRegistry<AppComponentDependency> {
    ScreenBuilderRegistry(dependency: dependency) { dependency, screenParams in
      let identifier = screenParams.identifier
      
      switch identifier {
      default:
        return MissingScreenBuilder(dependencies: dependency)
      }
    }
  }
}
