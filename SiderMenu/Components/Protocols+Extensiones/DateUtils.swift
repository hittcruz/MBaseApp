//
//  DateUtils.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 27/06/23.
//

import UIKit

enum MonthTranslations: String {
    case January = "january"
    case February = "february"
    case March = "march"
    case April = "april"
    case May = "may"
    case June = "june"
    case July = "july"
    case August = "august"
    case September = "september"
    case October = "october"
    case November = "november"
    case December = "december"

    
    func getLocalized() -> String {
        switch self {
        case .January:
            return "Enero"
        case .February:
            return "Febrero"
        case .March:
            return "Marzo"
        case .April:
            return "Abril"
        case .May:
            return "Mayo"
        case .June:
            return "Junio"
        case .July:
            return "Julio"
        case .August:
            return "Agosto"
        case .September:
            return "Septiembre"
        case .October:
            return "Octubre"
        case .November:
            return "Noviembre"
        case .December:
            return "Diciembre"
        }
    }
}

enum WeekTranslations: String {
    case Monday = "monday"
    case Tuesday = "tuesday"
    case Wednesday = "wednesday"
    case Thursday = "thursday"
    case Friday = "friday"
    case Saturday = "saturday"
    case Sunday = "sunday"

    func getLocalized() -> String {
        switch self {
        case .Monday:
            return "Lunes"
        case .Tuesday:
            return "Martes"
        case .Wednesday:
            return "Miercoles"
        case .Thursday:
            return "Jueves"
        case .Friday:
            return "Viernes"
        case .Saturday:
            return "Sabado"
        case .Sunday:
            return "Domingo"
        }
    }
}

final class DateUtils {

    /*
     * How formatter works: "MMM dd YYYY hh:mm a"
     */

    class func getStringTitleDateInCurrentLanguage(_ date: Date) -> String {
        let weekFormat = "EEEE"
        let dayFormat = "dd"
        let monthFormat = "MMMM"
        let yearFormat = "YYYY"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = weekFormat
        let week = dateFormatter.string(from: date)
        dateFormatter.dateFormat = dayFormat
        let day = dateFormatter.string(from: date)
        dateFormatter.dateFormat = monthFormat
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = yearFormat
        let year = dateFormatter.string(from: date)
        guard let monthTranslated = MonthTranslations(rawValue: month.lowercased())?.getLocalized() else {return ""}
        guard let weekTranslated = WeekTranslations(rawValue: week.lowercased())?.getLocalized() else {return ""}

        return "\(weekTranslated) \(day) \(monthTranslated) \(year)"
    }

    class func getStringDateFrom(_ formatter: String, _ input: Int) -> String {
        let formatedInput: Double = Double(input)/1000
        let date = NSDate(timeIntervalSince1970: round(formatedInput))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: date as Date)
    }

    class func getStringDateFrom(_ formatter: String, _ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: date as Date)
    }

    class func getStringDateFromTuple(_ formatter: String, _ input: Int) -> (String, Date) {
        let formatedInput: Double = Double(input)/1000
        let date = NSDate(timeIntervalSince1970: round(formatedInput))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = formatter
        return (dateFormatter.string(from: date as Date), date as Date)
    }

    class func getTimestampFromDate(_ input: Date) -> Int {
        let interval = input.timeIntervalSince1970
        let prueba = Int(interval)
        return prueba * 1000
    }

    class func getDateFromTimestamp(_ input: Int) -> Date {
        let formatedInput: Double = Double(input)/1000
        let date = Date(timeIntervalSince1970: round(formatedInput))

        return date
    }
    class func createYear(_ input: Int) -> String {
           return getStringDateFrom("YYYY", input).uppercased()
       }
    class func createMonth(_ input: Int) -> String {
        return getStringDateFrom("MMM", input).uppercased()
    }

    class func createDay(_ input: Int) -> String {
        return getStringDateFrom("dd", input)
    }

    class func createDate(_ start: Int, _ end: Int) -> String {
        return getStringDateFrom("HH:mm", start) + " to " + getStringDateFrom("HH:mm", end)
    }

    class func compareEqualDates(_ date1: Date, _ date2: Date) -> Bool {
        let date1String = getStringDateFrom("MMM dd YYYY", date1)
        let date2String = getStringDateFrom("MMM dd YYYY", date2)
        return date1String == date2String
    }
    
    class  func getcurrentDate(dato: String) -> String {
        let full = Date()
        let format = DateFormatter()
        format.dateFormat = dato
        return format.string(from: full)}
    
    class func convertMilliseconds(number: Int) -> String {
        let date = Date(timeIntervalSince1970: (Double(number) / 1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh mm"
        return dateFormatter.string(from: date)
    }
    class func convertMillisecondsDate(number: Int , fec : String) -> String {
        let date = Date(timeIntervalSince1970: (Double(number) / 1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fec
        return dateFormatter.string(from: date)
    }
    
    class func getAgeByDate(date: String) -> (Int,Int,Int) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        let dateOfBirth = dateFormater.date(from: date) ?? Date()
        let calender = Calendar.current
        let dateComponent = calender.dateComponents([.year, .month, .day], from: dateOfBirth, to: Date())
        return (dateComponent.year!, dateComponent.month!, dateComponent.day!)
    }
    
    class  func getYearBeforeCurrent() -> Int64 {
        let previousDate = Calendar.current.date(byAdding: .year , value: -1, to: Date())
        let currentDate = previousDate
        let since1970 = currentDate!.timeIntervalSince1970
        return Int64(since1970 * 1000)
    }
    
    class  func compareEqualDates(firstDate: String, secondDate: String) -> Bool {
        var same: Bool = false
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let firstDate = formatter.date(from: firstDate)
        let secondDate = formatter.date(from: secondDate)

        if firstDate?.compare(secondDate!) == .orderedSame {
            same = true
        }
        return same
    }

    class  func compareIfTheFirstDateIsLess(firstDate: String, secondDate: String) -> Bool{
        var isOlder: Bool = false
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let firstDate = formatter.date(from: firstDate)
        let secondDate = formatter.date(from: secondDate)

        if firstDate?.compare(secondDate!) == .orderedAscending {
            isOlder = true
        }
        return isOlder
    }
    
    class func startingDateLessThanOrEqual(firstDate: String, secondDate: String) -> Bool{
      var lessEqual: Bool = false
      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM/yyyy"
      let firstDate = formatter.date(from: firstDate)
      let secondDate = formatter.date(from: secondDate)

      if firstDate?.compare(secondDate!) == .orderedAscending || firstDate?.compare(secondDate!) == .orderedSame {
          lessEqual = true
      }
      return lessEqual
  }
    
  class  func convertStringDateToMillisec(date : String) -> Int {
            let strTime = date
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let ObjDate = formatter.date(from: strTime)
        let millisec = ObjDate!.timeIntervalSince1970 * 1000
        return Int(millisec)
    }
    
    class  func convertStringFormartDateTimeToMilliseconds(date : String) -> Int {
              let strTime = date
              let formatter = DateFormatter()
              formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
              let ObjDate = formatter.date(from: strTime)
          let millisec = ObjDate!.timeIntervalSince1970 * 1000
          return Int(millisec)
      }
    class func getCurrentMillis()-> Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
