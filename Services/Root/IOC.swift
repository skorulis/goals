//
//  IOC.swift
//  Magic
//
//  Created by Alexander Skorulis on 28/8/21.
//

import Foundation

import Swinject
import SwinjectAutoregistration

public final class IOC {
    
    static let shared: IOC = IOC()
    
    public let container: Container
    
    public init() {
        container = Container()
        setupCoordinators()
        setupFactories()
        setupServices()
        setupViewModels()
        setupProcessors()
        setupAccess()
    }
    
    private func setupFactories() {
        container.register(GenericFactory.self) { (_) -> GenericFactory in
            return GenericFactory(container: self.container)
        }
        .inObjectScope(.container)
    }
    
    private func setupProcessors() {
        
    }
    
    private func setupAccess() {
        container.autoregister(PersistenceController.self, initializer: PersistenceController.init)
            .inObjectScope(.container)
    }
    
    private func setupCoordinators() {
        
    }
    
    private func setupServices() {
        container.autoregister(RealmService.self, initializer: RealmService.init)
            .inObjectScope(.container)
    }
    
    private func setupViewModels() {
        container.autoregister(GoalListViewModel.self, initializer: GoalListViewModel.init)
        container.autoregister(GoalEditViewModel.self, argument: Goal.self, initializer: GoalEditViewModel.init)
    }
    
    func resolve<ServiceType>(_ type: ServiceType.Type) -> ServiceType? {
        return container.resolve(type)
    }
    
}
