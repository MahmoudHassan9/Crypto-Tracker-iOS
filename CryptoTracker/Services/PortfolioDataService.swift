//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Mahmoud hassan on 02/08/2026.
//

import CoreData
import Foundation

protocol PortfolioDataServiceProtocol {
    func getPortfolio() throws -> [PortfolioEntity]
    func updatePortfolio(coin: CoinModel, amount: Double) throws
        -> PortfolioEntity?
    func delete(entity: PortfolioEntity) throws
    func add(coin: CoinModel, amount: Double) throws -> PortfolioEntity
    func update(entity: PortfolioEntity, amount: Double) throws
        -> PortfolioEntity
}

final class PortfolioDataService: PortfolioDataServiceProtocol {

    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        }
    }

    // MARK: PUBLIC

    func getPortfolio() throws -> [PortfolioEntity] {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            return try container.viewContext.fetch(request)
        } catch {
            throw error
        }
    }

    func updatePortfolio(coin: CoinModel, amount: Double) throws
        -> PortfolioEntity?
    {
        let entities = try getPortfolio()

        if let entity = entities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                return try update(entity: entity, amount: amount)
            } else {
                try delete(entity: entity)
                return nil
            }
        } else {
            return try add(coin: coin, amount: amount)
        }
    }

    // MARK: PRIVATE

    func add(coin: CoinModel, amount: Double) throws -> PortfolioEntity {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        try save()
        return entity
    }

    func update(entity: PortfolioEntity, amount: Double) throws
        -> PortfolioEntity
    {
        entity.amount = amount
        try save()
        return entity
    }

    func delete(entity: PortfolioEntity) throws {
        container.viewContext.delete(entity)
        try save()
    }

    private func save() throws {
        do {
            try container.viewContext.save()
        } catch {
            throw error
        }
    }
}
