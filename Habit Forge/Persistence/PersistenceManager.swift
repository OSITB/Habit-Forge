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
    func fetchHabit(with id: UUID) -> Habit?
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
        let habit = Habit(context: context)
        
        habit.name = name
        habit.icon = icon
        habit.id = UUID()
        habit.createdAt = Date()
        
        do {
            try context.save()
            return habit
        } catch {
            print("Ошибка создания привычки \(error)")
            return nil
        }
    }
    
    func fetchHabits() -> [Habit] {
        let request = NSFetchRequest<Habit>(entityName: "Habit")
        return (try? context.fetch(request)) ?? []
    }
    
    func fetchHabit(with id: UUID) -> Habit? {
        let request = NSFetchRequest<Habit>(entityName: "Habit")
        request.predicate = NSPredicate(format: "id == %&", id as CVarArg)
        
        do {
            return try context.fetch(request).first   // возврат массива с привычками
        } catch {
            print("Ошибка загрузки привычки: \(error)")
            return nil   // если ошибка - nil
        }
    }
    
    func updateHabit(_ habit: Habit) {
        save()
    }
    
    func deleteHabit(_ habit: Habit) {
        context.delete(habit)
        save()
    }
    
    func addCompletion(for habit: Habit, date: Date) -> Completion? {
        let completion = Completion(context: context)
        
        completion.id = UUID()
        completion.date = date
        completion.habit = habit
        
        
        do {
            try context.save()
            return completion
        } catch {
            print("Ошибка \(error)")
            return nil
        }
    }
    
    func deleteCompletion(_ completion: Completion) {
        context.delete(completion)
        save()
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
