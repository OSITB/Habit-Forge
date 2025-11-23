//
//  Habit.swift
//  Habit Forge
//
//  Created by Илья Быков on 19.11.2025.
//

import Foundation
import CoreData

extension Habit {
    
    var currentStreak: Int {
        
        guard let completions = completions as? Set<Completion> else {
            return 0
        }
        
        if completions.isEmpty {
            return 0
        }
        
        let calendar = Calendar.current
        
        let dates = completions.compactMap { $0.date}
         
        let uniqueDays = Set(dates.map { calendar.startOfDay(for: $0 ) } )
        
        let sortedDays = uniqueDays.sorted { $0 > $1 }
        
        var streak = 0
        let today = calendar.startOfDay(for: Date())
        
        // Начало даты проверки
        var expectedDate = today
        
        // Если нет сегодня отметки, начало со вчерашнего дня
        if !sortedDays.contains(today) {
            guard let yesterday = calendar.date(byAdding: .day, value: -1, to: today) else {
                return 0
            }
            expectedDate = yesterday
        }
        
        // Перебор по отсортированным дням
        for day in sortedDays {
            // Проверка ожидаемой даты
            if day == expectedDate {
                streak += 1
                // Переход на день назад
                guard let previousDay = calendar.date(byAdding: .day, value: -1, to: expectedDate) else {
                    break
                }
                expectedDate = previousDay
            } else {
                // В противном случае прерываем
                break
            }
        }
        
        return streak
    }
}
