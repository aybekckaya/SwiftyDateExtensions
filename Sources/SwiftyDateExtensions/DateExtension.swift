//
//  DateExtension.swift
//  SwiftyDateExtension
//
//  Created by Aybek Can Kaya on 23.07.2021.
//

import Foundation

// MARK: - Weekday
public enum WeekDay: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    var title: String {
        switch self {
        case .friday: return "Friday "
        case .monday: return "Monday"
        case .saturday: return "Saturday"
        case .sunday: return "Sunday"
        case .thursday: return "Thursday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        }
    }
}

// MARK: - Init
public extension Date {
    init(from timeInterval: TimeInterval) {
        self = Date(timeIntervalSince1970: timeInterval)
    }
    
    init?(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        let calendar = Calendar.current
        guard let date = calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)) else { return nil }
        self = date
    }
}

// MARK: - Getters
public extension Date {
    static func timeIntervalFromGMT(for timeZone: TimeZone) -> TimeInterval {
        return TimeInterval(timeZone.secondsFromGMT())
    }
    
    static func numberOfDays(in month: Int, year: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
}

// MARK: - Converters
public extension Date {
    func toString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func toGMTFromLocal() -> Date {
        let dateNew = self - Int(Date.timeIntervalFromGMT(for: TimeZone.current)).seconds
        return dateNew
    }
    
    func toLocalFromGMT() -> Date {
        let dateNew = self + Int(Date.timeIntervalFromGMT(for: TimeZone.current)).seconds
        return dateNew
    }
    
    func convertToTimeZone(_ timeZone: TimeZone) -> Date {
        let gmtTime = self.toGMTFromLocal()
        let convertedTime = gmtTime +  Int(Date.timeIntervalFromGMT(for: timeZone)).seconds
        return convertedTime
    }
}

// MARK: - Date Components
extension DateComponents {
    internal static let allComponents: [Calendar.Component] =  [.nanosecond, .second, .minute, .hour,
                                                                .day, .month, .year, .yearForWeekOfYear,
                                                                .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
                                                                .weekOfMonth]
    
    public static prefix func - (rhs: DateComponents) -> DateComponents {
        var components = DateComponents()
        components.era = rhs.era.map(-)
        components.year = rhs.year.map(-)
        components.month = rhs.month.map(-)
        components.day = rhs.day.map(-)
        components.hour = rhs.hour.map(-)
        components.minute = rhs.minute.map(-)
        components.second = rhs.second.map(-)
        components.nanosecond = rhs.nanosecond.map(-)
        components.weekday = rhs.weekday.map(-)
        components.weekdayOrdinal = rhs.weekdayOrdinal.map(-)
        components.quarter = rhs.quarter.map(-)
        components.weekOfMonth = rhs.weekOfMonth.map(-)
        components.weekOfYear = rhs.weekOfYear.map(-)
        components.yearForWeekOfYear = rhs.yearForWeekOfYear.map(-)
        return components
    }
}

// MARK: - Finder
public extension Date {
    func next(_ weekDay: WeekDay) -> Date {
        let needleWeekDayIndex: Int = weekDay.rawValue
        let foundDate = Array(1 ..< 8).first { dayIndex -> Bool in
            let date = self + dayIndex.days
            return date.weekDay == needleWeekDayIndex
        }.map { dayIndex -> Date in
            return self + dayIndex.days
        }
        return foundDate!
    }
    
    func previous(_ weekDay: WeekDay) -> Date {
        let needleWeekDayIndex: Int = weekDay.rawValue
        let foundDate = Array(1 ..< 8).first { dayIndex -> Bool in
            let date = self - dayIndex.days
            return date.weekDay == needleWeekDayIndex
        }.map { dayIndex -> Date in
            return self - dayIndex.days
        }
        return foundDate!
    }
}

// MARK: - Math
public func - (lhs: Date, rhs: Date) -> DateComponents {
    return Calendar.current.dateComponents(Set(DateComponents.allComponents), from: rhs, to: lhs)
}

public func + (lhs: Date, rhs: DateComponents) -> Date {
    return Calendar.current.date(byAdding: rhs, to: lhs)!
}

public func + (lhs: DateComponents, rhs: Date) -> Date {
    return (rhs + lhs)
}

public func - (lhs: Date, rhs: DateComponents) -> Date {
    return (lhs + (-rhs))
}

public func + (lhs: Date, rhs: TimeInterval) -> Date {
    return lhs.addingTimeInterval(rhs)
}

// MARK: - Integer + Date Component
public extension Int {
    internal func toDateComponents(type: Calendar.Component) -> DateComponents {
        var dateComponents = DateComponents()
        DateComponents.allComponents.forEach( { dateComponents.setValue(0, for: $0 )})
        dateComponents.setValue(self, for: type)
        dateComponents.setValue(0, for: .era)
        return dateComponents
    }
    
    var nanoseconds: DateComponents {
        return toDateComponents(type: .nanosecond)
    }

    var seconds: DateComponents {
        return toDateComponents(type: .second)
    }

    var minutes: DateComponents {
        return toDateComponents(type: .minute)
    }

    var hours: DateComponents {
        return toDateComponents(type: .hour)
    }
    
    var days: DateComponents {
        return toDateComponents(type: .day)
    }

    var weeks: DateComponents {
        return toDateComponents(type: .weekOfYear)
    }

    var months: DateComponents {
        return toDateComponents(type: .month)
    }

    var years: DateComponents {
        return toDateComponents(type: .year)
    }
}

// MARK: - Components
extension Date {
    public var day: UInt {
        return UInt(Calendar.current.component(.day, from: self))
    }
    
    public var month: UInt {
        return UInt(NSCalendar.current.component(.month, from: self))
    }
    
    public var year: UInt {
        return UInt(NSCalendar.current.component(.year, from: self))
    }
    
    public var hour: UInt {
        return UInt(NSCalendar.current.component(.hour, from: self))
    }
    
    public var minute: UInt {
        return UInt(NSCalendar.current.component(.minute, from: self))
    }
    
    public var second: UInt {
        return UInt(NSCalendar.current.component(.second, from: self))
    }
    
    public var weekDay: Int {
        return Calendar.current.component(.weekday, from: self)
    }
}


