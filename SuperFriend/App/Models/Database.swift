//
//  Database.swift
//  SuperFriend
//
//  Created by Sam Garson on 16/01/2025.
//

import Foundation
import SwiftData

/// A wrapper around SwiftData ModelContainer
final class Database {
    static let instance = Database()
    static func testInstance() -> Database {
        Database(useInMemoryStore: true)
    }

    @MainActor
    static func testInstance(with models: [any PersistentModel]) -> Database {
        let database = testInstance(), context = database.container.mainContext
        models.forEach { model in context.insert(model) }
        try? context.save()
        return database
    }

    static let models: [any PersistentModel.Type] = [
        Friend.self
    ]

    let container: ModelContainer

    init(useInMemoryStore: Bool = false) {
        let schema = Schema(Database.models)
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: useInMemoryStore
        )
        do {
            container = try ModelContainer(
                for: schema,
                configurations: configuration
            )
            if useInMemoryStore { print("sqlite in memory") }
            else { print("sqlite3 \"\(configuration.url.path(percentEncoded: false))\"") }
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    @MainActor
    func reset() {
        do {
            let context = container.mainContext
            try Database.models.forEach { model in
                try context.delete(model: model)
            }
        } catch {
            print("Failed to clear all Country and City data.")
        }
    }
}
