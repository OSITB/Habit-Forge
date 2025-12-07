//
//  ContentView.swift
//  Habit Forge
//
//  Created by Илья Быков on 19.11.2025.
//

import SwiftUI
import CoreData

struct HabitListView: View {
    
    @StateObject private var viewModel = HabitListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.habits) { habit in
                Text(habit.icon ?? "")
                Text(habit.name ?? "")
                Spacer()
                Text("􀙬 \(habit.currentStreak)")
            }
            .navigationTitle("Мои привычки")
            .toolbar {
                // кнопка + для создания привычки
            }
        }
    }
}

#Preview {
    HabitListView()
}
