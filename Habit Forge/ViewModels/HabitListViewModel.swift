//
//  HabitListViewModel.swift
//  Habit Forge
//
//  Created by Илья Быков on 19.11.2025.
//

import Foundation
import Combine

class HabitListViewModel: ObservableObject {
     
    @Published var habits: [Habit] = []
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    private let persistenceManager: PersistenceManagerProtocol
    
    init(persistenceManager: PersistenceManagerProtocol = PersistenceManager.shared) {
        self.persistenceManager = persistenceManager
        loadHabits()
    }
    
    // MARK: - Methods
    
    func loadHabits() {
        habits = persistenceManager.fetchHabits()
    }
    
    func toggleCompletion(for habit: Habit){
        if habit.isCompletedToday {
            let completion = habit.completions as? Set<Completion>
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            guard let todayCompletion = completion?.first(where: {
                guard let date = $0.date else { return false}
                return calendar.startOfDay(for: date) == today} ) else { return }
            persistenceManager.deleteCompletion(todayCompletion)
        } else {
            if persistenceManager.addCompletion(for: habit, date: Date()) == nil {
                showError = true
                errorMessage = "Не удалось сохранить отметку"
            }
        }
        loadHabits()
    }
    
    func deleteHabit(_ habit: Habit) {
        persistenceManager.deleteHabit(habit)
        loadHabits()
    }
}
