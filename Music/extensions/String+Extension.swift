//
//  String+Extension.swift
//  CamDigiKey
//
//  Created by Sann Chhailong on 26/8/21.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    
    func toDate(with format: String) -> Date? {
          
        let dateformatter = DateFormatter()
          dateformatter.dateFormat = format
        return dateformatter.date(from: self)
    }
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
extension Date {
    
    func defaultDateOnlyFormat() -> String {
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "dd MMM YYYY"
        return df.string(from: self)
    }
    
    
    func dateOnlyUTC() -> Date {
        let df = DateFormatter()
        df.timeZone = TimeZone(abbreviation: "UTC")
        df.dateFormat = "dd MMM YYYY"
        return df.date(from: df.string(from: self)) ?? self
    }
    
    func dateOnly() -> Date {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df.date(from: df.string(from: self)) ?? self
    }
    
    func stringWith(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        let locale = Locale(identifier: "en")
        df.locale = locale
        return df.string(from: self)
    }
    func timeAgoDisplay(to date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = .init(identifier: "en")
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: date)
        
    }
}
