

import NeedleFoundation
import SwiftUI

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class AppComponentDependencya34170097de9901d91dcProvider: AppComponentDependency {
    var routerService: RouterServiceProtocol {
        return rootComponent.routerService
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->AppComponent
private func factorydd68507f3f0624b74efcb3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AppComponentDependencya34170097de9901d91dcProvider(rootComponent: parent1(component) as! RootComponent)
}

#else
extension RootComponent: NeedleFoundation.Registration {
    public func registerItems() {

        localTable["rootView-some View"] = { [unowned self] in self.rootView as Any }
        localTable["appComponent-AppComponent"] = { [unowned self] in self.appComponent as Any }
        localTable["routerService-RouterServiceProtocol"] = { [unowned self] in self.routerService as Any }
        localTable["mutableRouterService-MutableRouterServiceProtocol"] = { [unowned self] in self.mutableRouterService as Any }
        localTable["exisitingRouterService-MutableRouterServiceProtocol?"] = { [unowned self] in self.exisitingRouterService as Any }
        localTable["screenBuilderegistry-ScreenBuilderRegistry"] = { [unowned self] in self.screenBuilderegistry as Any }
    }
}
extension AppComponent: NeedleFoundation.Registration {
    public func registerItems() {
        keyPathToName[\AppComponentDependency.routerService] = "routerService-RouterServiceProtocol"
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->RootComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->RootComponent->AppComponent", factorydd68507f3f0624b74efcb3a8f24c1d289f2c0f2e)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
