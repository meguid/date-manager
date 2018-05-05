//
//  DateManager.swift
//  Created by meguid
//
import Foundation

class DateManager {
    
    static var serverFormat = "yyyy-MM-dd HH:mm:ss"
    static var serverTimeZone = "UTC"

    static func getStringFromDate(date : Date, format : String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func getDateFromString(dateString : String, format : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    static func getTimeFromString(dateString : String, format : String, timeFormat : String, amSymbol : String, pmSymbol : String) -> String {
        
        let date = getDateFromString(dateString : dateString, format : format)
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = amSymbol
        dateFormatter.pmSymbol = pmSymbol
        dateFormatter.dateFormat = timeFormat
        return dateFormatter.string(from: date)
    }
    
    static func getComponentFromDate(dateString: String, format : String, component : Calendar.Component)-> Int {
        let date = getDateFromString(dateString : dateString, format : format)
        return get(component : component, date : date)
    }
    
    static func getCurrentComponent(component : Calendar.Component)-> Int {
        return get(component : component, date : Date())
    }
    
    static func isItToday(dateString : String, format : String) -> Bool {
        let date = getDateFromString(dateString : dateString, format : format)
        return Calendar.current.isDateInToday(date)
    }

    static func numOfWeeks(in year: Int) -> Int {
        func calculate(_ year: Int) -> Int {
            return (year + year/4 - year/100 + year/400) % 7
        }
        return (calculate(year) == 4 || calculate(year-1) == 3) ? 53 : 52
    }
    
    static func chatTimestamp(_ dateString : String) -> String {
        
        let date = getDate(dateString)
        
        if !equal(component: .year, date1: date, date2: Date()) {
            return convert(dateString: dateString, newFormat: "d MMM yyyy h:mm a")
        }else if !equal(component: .month, date1: date, date2: Date()) {
            return convert(dateString: dateString, newFormat: "d MMM h:mm a")
        }else if !equal(component: .day, date1: date, date2: Date()) {
            if Date().days(from: date) == 1 {
                return "yesterday"
            }
            return convert(dateString: dateString, newFormat: "d MMM h:mm a")
        }else{
            let minutes = Date().minutes(from: date)
            if minutes < 1 {
                return "now"
            }else if minutes < 60 {
                return "\(minutes) min ago"
            }else{
                return convert(dateString: dateString, newFormat: "h:mm a")
            }
        }
    }
    
    private static func convert(dateString : String, newFormat : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = serverFormat
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = newFormat
        return dateFormatter.string(from: date!)
    }
    
    private static func get(component : Calendar.Component, date : Date) -> Int {
        return Calendar.current.component(component, from: date)
    }
    
    private static func equal(component : Calendar.Component, date1 : Date, date2 : Date) -> Bool {
        return get(component: component, date: date1) == get(component: component, date: date2)
    }
    
    private static func getDate(_ dateString : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = serverFormat
        return dateFormatter.date(from: dateString)!
    }
    
    private static func convertToLocal(dateString : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: serverTimeZone)
        dateFormatter.dateFormat = serverFormat
        let date = dateFormatter.date(from: dateString)
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date!)
    }
}
