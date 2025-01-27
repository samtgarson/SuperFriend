//
//  ModelRepository.swift
//  SuperFriend
//
//  Created by Sam Garson on 20/01/2025.
//

import SwiftData
import SwiftUI

class ModelRepository<Model: PersistentModel> {
    var container: ModelContainer

    init(with container: ModelContainer = Database.instance.container) {
        self.container = container
    }

    /// Create or update this item in the database
    @MainActor
    func upsert(_ record: Model) throws {
        context.insert(record)
        try context.save()
    }

    /// Remove this item from the database
    @MainActor
    func delete(_ record: Model) throws {
        let recordId = record.persistentModelID
        try context.delete(model: Model.self, where: #Predicate<Model> { item in
            return item.persistentModelID == recordId
        })
        try context.save()
    }

    /// Find an item from the database
    @MainActor
    func find(with query: Predicate<Model>, sortBy: [SortDescriptor<Model>] = []) throws -> Model? {
        let records = try context.fetch(.init(predicate: query, sortBy: sortBy))
        return records.first
    }

    /// Find many items from the database
    @MainActor
    func query(with query: Predicate<Model> = Predicate.true, sortBy: [SortDescriptor<Model>] = []) throws -> [Model] {
        return try context.fetch(.init(predicate: query, sortBy: sortBy))
    }

    @MainActor
    private var context: ModelContext {
        container.mainContext
    }
}
