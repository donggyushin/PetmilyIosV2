//
//  BirthdayService.swift
//  Petmily
//
//  Created by 신동규 on 2020/12/27.
//

import Foundation


class BirthdayService {
    static let shared = BirthdayService()
    
    func getYearList() -> [String] {
        let date = Date()
        let calendar = Calendar.current
        var year = calendar.component(.year, from: date)
        var years:[String] = []
        for _ in 0...50 {
            years.append(String(year))
            year -= 1
        }
        return years
    }
    
    func getMonthList() -> [String] {
        var months:[String] = []
        for index in 1...12 {
            months.append(String(index))
        }
        return months
    }
    
    func getDayList() -> [String] {
        var days:[String] = []
        for index in 1...32 {
            days.append(String(index))
        }
        return days
    }
}
