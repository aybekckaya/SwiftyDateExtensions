import XCTest
@testable import SwiftyDateExtensions

final class SwiftyDateExtensionsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftyDateExtensions().text, "Hello, World!")
    }
    
    func testDateExtensions() {
        var date: Date
        var resDate: Date
        var resultDate: Date?
        var diff: DateComponents
        var dateText: String
        
        date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)!
        print("TimeZone : \(TimeZone.current), secondsDiff: \(TimeZone.current.secondsFromGMT())")
        resDate = date.toGMTFromLocal()
        print("Date New : \(resDate), Date: \(date)")
        print("Hour local: \(date.hour), gmt: \(resDate.hour)")
        print("asdasd")
        
        date = Date(year: 2021, month: 7, day: 23, hour: 12, minute: 12, second: 12)!
        resDate = date.next(WeekDay.saturday)
        XCTAssert(resDate.day == 24, "Curr: \(resDate.day)")
        resDate = date.next(WeekDay.sunday)
        XCTAssert(resDate.day == 25, "Curr: \(resDate.day)")
        resDate = date.next(WeekDay.monday)
        XCTAssert(resDate.day == 26, "Curr: \(resDate.day)")
        resDate = date.next(WeekDay.friday)
        XCTAssert(resDate.day == 30, "Curr: \(resDate.day)")
        
        resDate = date.previous(WeekDay.thursday)
        XCTAssert(resDate.day == 22, "Curr: \(resDate.day)")
        resDate = date.previous(WeekDay.wednesday)
        XCTAssert(resDate.day == 21, "Curr: \(resDate.day)")
        resDate = date.previous(WeekDay.friday)
        XCTAssert(resDate.day == 16, "Curr: \(resDate.day)")
        
        date = Date(year: 2021, month: 7, day: 23, hour: 12, minute: 12, second: 12)!
        resDate = date.convertToTimeZone(Zones.europeAthens.toTimezone())
        XCTAssert(resDate.hour == 12, "Curr: \(resDate.hour)")
        
        date = Date(year: 2021, month: 7, day: 23, hour: 12, minute: 12, second: 12)!
        resDate = date.convertToTimeZone(Zones.americaNewYork.toTimezone())
        XCTAssert(resDate.hour == 5, "Curr: \(resDate.hour)")
        
        date = Date(year: 2021, month: 7, day: 13, hour: 12, minute: 21, second: 3)
        XCTAssert(date != nil, "Date should not be nil")
        
        XCTAssert(date!.day == 13, "Curr : \(date!.day)")
        XCTAssert(date!.month == 7, "Curr: \(date!.month)")
        XCTAssert(date!.second == 3, "Curr: \(date!.second)")
        
        resultDate = date! + 1.days
        XCTAssert(resultDate != nil)
        XCTAssert(resultDate!.day == 14, "Curr : \(resultDate!.day)")
        XCTAssert(resultDate!.month == 7, "Curr: \(resultDate!.month)")
        
        resultDate = date! + 1.days - 3.days
        XCTAssert(resultDate != nil)
        XCTAssert(resultDate!.day == 11, "Curr : \(resultDate!.day)")
        XCTAssert(resultDate!.month == 7, "Curr: \(resultDate!.month)")
    
        diff = resultDate! - date!
        XCTAssert(diff.day == -2, "Curr: \(diff.day)")
        
       date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)
        dateText = date!.toString(with: "dd MM yyyy HH:mm:ss")
        XCTAssert(dateText == "01 01 2000 12:00:00", "Curr: \(dateText)")
        
        // Europe / Istanbul timezone
        date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)!
        resultDate = date!.toGMTFromLocal()
        XCTAssert(resultDate!.hour == 9, "Curr : \(resultDate!.hour)" )
        
        resultDate = date!.toLocalFromGMT()
        XCTAssert(resultDate!.hour == 15, "Curr :\(resultDate!.hour)")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
