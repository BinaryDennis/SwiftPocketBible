import Foundation

extension Date {
    
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    var iso8601: String {
        return Date.iso8601Formatter.string(from: self)
    }
}

extension String {
    var dateFromISO8601: Date? {
        return Date.iso8601Formatter.date(from: self)
    }
}


extension Date {
    
 public func add(years: Int = 0,
                    months: Int = 0,
                    days: Int = 0,
                    hours: Int = 0,
                    minutes: Int = 0,
                    seconds: Int = 0) -> Date {
        let userCalendar = Calendar.current
        var newDate = self

        if years != 0 {
            newDate = userCalendar.date(byAdding: .year, value: years, to: newDate) ?? self
        }

        if months != 0 {
            newDate = userCalendar.date(byAdding: .month, value: months, to: newDate) ?? self
        }

        if days != 0 {
            newDate = userCalendar.date(byAdding: .day, value: days, to: newDate) ?? self
        }

        if hours != 0 {
            newDate = userCalendar.date(byAdding: .hour, value: hours, to: newDate) ?? self
        }

        if minutes != 0 {
            newDate = userCalendar.date(byAdding: .minute, value: minutes, to: newDate) ?? self
        }

        if seconds != 0 {
            newDate = userCalendar.date(byAdding: .second, value: seconds, to: newDate) ?? self
        }

        return newDate
    }
}
