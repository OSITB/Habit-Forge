//
//  Persistence.swift
//  Habit Forge
//
//  Created by Илья Быков on 19.11.2025.
//

import Foundation
import CoreData

// Контракт
protocol PersistenceManagerProtocol {
    func createHabit(name: String, icon: String) -> Habit?
    func fetchHabits() -> [Habit]
    func updateHabit(_ habit: Habit)
    func deleteHabit(_ habit: Habit)
    
    func addCompletion(for habit: Habit, date: Date) -> Completion?
    func deleteCompletion(_ completion: Completion)
    
    func save()
}

// Реализация для CoreData
class PersistenceManager: PersistenceManagerProtocol {
    
    static let shared = PersistenceManager()
    
    private let container: NSPersistentContainer
    private var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: "Habit_Forge")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreData failed to load: \(error)")
            }
        }
        print("CoreData running!")
    }
    
    // MARK: - Habit CRUD
    
    func createHabit(name: String, icon: String) -> Habit? {
        <#code#>
    }
    
    func fetchHabits() -> [Habit] {
        let request = NSFetchRequest<Habit>(entityName: "Habit")
        request.predicate = NSPredicate(format: "id == %@", id as! CVarArg)
        return try? container.viewContext.fetch(request).first
    }
    
    func updateHabit(_ habit: Habit) {
        save()
    }
    
    func deleteHabit(_ habit: Habit) {
        <#code#>
    }
    
    func addCompletion(for habit: Habit, date: Date) -> Completion? {
        <#code#>
    }
    
    func deleteCompletion(_ completion: Completion) {
        <#code#>
    }
    
    func save() {
        do {
            try context.save()
            print("Сохранение успешно завершено")
        } catch {
            print("Ошибка \(error)")
        }
    }
}
