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
        guard let index = habits.firstIndex(where: { $0.id == habit.id}) else { return }
        if habit.isCompletedToday {
            let completion = habit.completions as? Set<Completion>
            // let todayCompletion = completion?.first(where: )
        } else {
            persistenceManager.addCompletion(for: habit, date: Date())
        }
    }
    
    func deleteHabit(_ habit: Habit) {
        
    }
}
