//
//  Date+Extension.swift
//
//  Created by Adriano Song on 1/31/19.
//

import Foundation

public extension Date {
    
    enum TimeZoneType: String {
        case utc = "UTC"
        case gmt = "GMT"
        case pst = "PST"
        case brt = "BRT"
    }
    
    enum Format: String {
        /// 2018-06-20
        case short = "yyyy-MM-dd"
        ///12.09.18
        case shortDotted = "dd.MM.yy"
        ///09/12/2018
        case shortSlashed = "09/12/2018"
        ///09-12-2018 14:11
        case shortWithTime = "MM-dd-yyyy HH:mm"
        /// 20:14:01
        case timeShort = "HH:mm:ss"
        ///10:41:02.112
        case timeShortWithMiliseconds = "HH:mm:ss.SSS"
        /// Nov 11, 2018
        case monthMediumDayYear = "MMM dd, yyyy"
        /// Nov, 11 2018 20:14:01
        case monthMediumDayYearTime = "MMM, dd yyyy HH:mm:ss"
        /// Nov 11, 2018 20:14:01
        case monthMediumDayYearTime2 = "MMM dd, yyyy HH:mm:ss"
        /// Jan 2019
        case monthMediumYear = "MMM yyyy"
        ///Sep 12, 2:11 PM
        case monthMediumDayWithSimpleTime = "MMM d, h:mm a"
        ///Sep 12, 20:14:01
        case monthMediumDayWithTime = "MMM d, HH:mm:ss"
        /// Jan
        case onlyMonthMedium = "MMM"
        /// Jan 11
        case monthMediumDay = "MMM dd"
        ///Full Format
        case full = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        ///Semi Full Format
        case semiFull = "yyyy-MM-dd'T'HH:mm:ss"
        ///Wednesday, Sep 12, 2018
        case header = "EEEE, MMM d, yyyy"
    }
    
    func string(format: Format) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    static func date(from dateString: String?, format: String) -> Date? {
        
        guard let date = dateString else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date)
    }
    
    static func date(from dateString: String?, format: Format) -> Date? {
        
        guard let date = dateString else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: date)
    }
    
    /**
       Convert date string to local date/timezone string
     
     - Parameter format: `Date.Format`
     - Parameter timeZoneAbbreviation: `Date.TimeZoneType`
     - Returns: `String?`
     */
    static func date(
        from dateString: String,
        format: Date.Format,
        timeZoneAbbreviation: Date.TimeZoneType) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: timeZoneAbbreviation.rawValue)
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = Date.Format.monthMediumDayWithTime.rawValue
            
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        let components = DateComponents(day: 1, second: -1)
        return Calendar.current.date(byAdding: components, to: self) ?? Date()
    }
    
    var components: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
    }

    func getDays() -> [Int] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: self) else { return [] }
        let days = range.map({Int($0)})
        let today = Calendar.current.component(.day, from: Date())-1
        return isThisMonth(date: Date()) ? Array(days[0...today]) : days
    }
    
    /// Simple current time extraction (return: hh:mm:ss)
    func simpleExtractCurrentTime() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        let minute = Calendar.current.component(.minute, from: self)
        let seconds = Calendar.current.component(.second, from: self)
        
        return "\(hour):\(minute):\(seconds)"
    }
    
    func extractHourMinOrSecondsStringFromDate(dateComponent: Calendar.Component) -> String {
        
        func addingOrNotLeftSizeZero(value: Int) -> String {
            return value > 9 ? "\(value)" : "0\(value)"
        }
        
        switch dateComponent {
        case .hour:
            let hour = Calendar.current.component(.hour, from: self)
            return addingOrNotLeftSizeZero(value: hour)
            
        case .minute:
            let minute = Calendar.current.component(.minute, from: self)
            return addingOrNotLeftSizeZero(value: minute)
            
        case .second:
            let seconds = Calendar.current.component(.second, from: self)
            return addingOrNotLeftSizeZero(value: seconds)
            
        default:
            return ""
        }
    }
    
    private func isThisMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    
    static func getMonthAndYear(dateSelected: String) -> (Int, Int) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        let newDate = dateFormatter.date(from: dateSelected)
        let year = Calendar.current.component(.year, from: newDate ?? Date())
        let month = Calendar.current.component(.month, from: newDate ?? Date())
        
        return (month, year)
    }
    
    static func getCurrentYear() -> Int {
        return Calendar.current.component(.year, from: Date())
    }
    
    static func getMonthSymbolFormattedDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let newDate = dateFormatter.date(from: date)
        let year = Calendar.current.component(.year, from: newDate ?? Date())
        let month = Calendar.current.component(.month, from: newDate ?? Date())
        let day = Calendar.current.component(.day, from: newDate ?? Date())
        
        return "\(dateFormatter.shortMonthSymbols[month - 1])/\(day)/\(year)"
    }
    
    static func isCurrentDayToday(date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
    
    static func greaterThanToday(date: Date) -> Bool {
        return Calendar.current.compare(date, to: Date(), toGranularity: .day) == .orderedDescending
    }
    
    static func isBetweenOrEqualToTwoDates(date: Date, startDate: Date, endDate: Date?) -> Bool {
        
        let startDateVerification =
            Calendar.current.compare(date, to: startDate, toGranularity: .day) == .orderedSame ||
            Calendar.current.compare(date, to: startDate, toGranularity: .day) == .orderedDescending
        
        guard let finalDate = endDate else {
            return startDateVerification
        }
        
        if startDateVerification {
            return
                Calendar.current.compare(date, to: finalDate, toGranularity: .day) == .orderedSame ||
                Calendar.current.compare(date, to: finalDate, toGranularity: .day) == .orderedAscending
        }
        
        return startDateVerification
    }
    
    static func isInThePast(date: Date) -> Bool {
        return Calendar.current.compare(date, to: Date(), toGranularity: .month) == .orderedAscending
    }
    
    func isSameMonth(date: Date) -> Bool {
        return Calendar.current.compare(date, to: self, toGranularity: .month) == .orderedSame
    }
    
    func isSameYear(date: Date) -> Bool {
        return Calendar.current.compare(date, to: self, toGranularity: .year) == .orderedSame
    }
    
    static func daysBetweenTwoDates(_ firstDate: Date?,
                                    _ secondDate: Date?,
                                    ignoreSameDay: Bool = false) -> Int {
        
        guard let firstDate = firstDate, let secondDate = secondDate else {
            return 0 
        }
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: firstDate)
        let date2 = calendar.startOfDay(for: secondDate)
        
        guard var days = calendar.dateComponents([.day], from: date1, to: date2).day else { return 0 }
        
        if ignoreSameDay, days > 0 {
            days -= 1
        }
        return days
    }
    
    static func defineDatesArray() -> [String] {
        
        var datesArray = [String]()
        
        let dateFormatter = DateFormatter()
        let today = Date()
        let minYearDate = today.adding(.year, value: -16)
        
        let minYear = Calendar.current.component(.year, from: minYearDate)
        var currentYear = Calendar.current.component(.year, from: today)
        
        while currentYear != minYear {
            let isThisYear = currentYear == Calendar.current.component(.year, from: today)
            let topLimit = isThisYear ? Calendar.current.component(.month, from: today) : 12
            var yearArray = [String]()
            
            for index in 0..<topLimit {
                yearArray.append("\(dateFormatter.monthSymbols[index]) \(currentYear)")
            }
            
            yearArray.reverse()
            
            datesArray.append(contentsOf: yearArray)
            
            currentYear -= 1
        }
        
        return datesArray
    }
    
    static func isTheLastDayOfThisMonth(date: Date) -> Bool {
        
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        guard var lastDayOfMonth = Calendar.current.date(from: components)?.adding(.month, value: 1) else {
            return false
        }
        
        lastDayOfMonth = lastDayOfMonth.adding(.day, value: -1)
        
        return Calendar.current.compare(lastDayOfMonth.startOfDay,
                                        to: date.startOfDay,
                                        toGranularity: .day) == .orderedSame
    }
    
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self) ?? Date()
    }
    
    static func distanceBetweenDates(fromDate: Date, toDate: Date) -> (weeks: Int?, days: Int) {
        let components = Set<Calendar.Component>([.weekOfYear, .year, .day])
        
        let distanceBetweenDates = Calendar.current.dateComponents(components, from: fromDate, to: toDate)
        let day = (distanceBetweenDates.day ?? 0) + 1
        
        return (weeks: distanceBetweenDates.weekOfYear, days: day)
    }
    
    func next(_ weekday: Weekday,
                     direction: Calendar.SearchDirection = .forward,
                     considerToday: Bool = false) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(weekday: weekday.rawValue)
        
        if considerToday &&
            calendar.component(.weekday, from: self) == weekday.rawValue {
            return self
        }
        
        return calendar.nextDate(after: self,
                                 matching: components,
                                 matchingPolicy: .nextTime,
                                 direction: direction) ?? Date()
    }
    
    var firstDayOfMonth: Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: self.startOfDay)
        return Calendar.current.date(from: components)
    }

    var lastDayOfMonth: Date? {
        let calendar = Calendar.current
        let components = DateComponents(day:1)
        guard let startOfNextMonth = calendar.nextDate(after: self,
                                                       matching: components,
                                                       matchingPolicy: .nextTime) else {
                                                        return nil
        }
        return calendar.date(byAdding:.day, value: -1, to: startOfNextMonth)
    }
    
    var weekDay: Weekday {
        let day = Calendar.current.component(.weekday, from: self)
        guard let weekDay = Weekday(rawValue: day) else {
            assertionFailure("WeekDay not available")
            return .sunday
        }
        return weekDay
    }
    
    enum Weekday: Int {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    }
    
    static func defaultReminder() -> Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) ?? Date()
    }
}

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }
    
    public func advanced(by timeInterval: TimeInterval) -> Date {
        return self + timeInterval
    }
}
