# SwiftyDateExtensions

<p align = "left"> Date helper extension that helps to manipulate and create time objects easier. It is written with intensive unit tests to make sure everything is safe.</p>

## Installation

### Manuel
Download project. Copy and paste `DateExtension.swift` and `Zones.swift` to your project's folder.

### [Swift Package Manager for Apple platforms](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

Select Xcode menu `File > Swift Packages > Add Package Dependency` and enter repository URL with GUI.  
```
Repository: https://github.com/aybekckaya/SwiftyDateExtensions.git
```

### [Swift Package Manager](https://swift.org/package-manager/)

Add the following to the dependencies of your `Package.swift`:
```swift
.package(url: "https://github.com/aybekckaya/SwiftyDateExtensions.git", from: "1.0.0")
```
## Usage

Creating date from numbers
```swift
 let date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)!
 print(date.toString(with: "dd MM yyyy HH:mm:ss")) // 01 01 2000 12:00:00
```

TimeZone conversions (I am at Europe/Istanbul time zone)
```swift
   date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)!
   let gmtDate = date.toGMTFromLocal()
   print(gmtDate.toString(with: "dd MM yyyy HH:mm:ss")) // 01 01 2000 09:00:00
```

```swift
   date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)!
   let localTime = date.toLocalFromGMT()
   print(localTime.toString(with: "dd MM yyyy HH:mm:ss")) // 01 01 2000 15:00:00
```

```swift
   date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)!
   let newYork = date.convertToTimeZone(Zones.americaNewYork.toTimezone())
   print(newYork.toString(with: "dd MM yyyy HH:mm:ss")) // 01 01 2000 05:00:00
```

Next and Previous week days

```swift
   date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)!
   let nextSaturday = date.next(WeekDay.saturday)
   print(nextSaturday.toString(with: "dd MM yyyy HH:mm:ss")) // 08 01 2000 12:00:00
   let previousWednesday = date.previous(WeekDay.wednesday)
   print(previousWednesday.toString(with: "dd MM yyyy HH:mm:ss")) // 29 12 1999 12:00:00
```

Date Components

```swift
   date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)!
   print("Day: \(date.day), hour: \(date.hour), weekday: \(date.weekDay)") // Day: 1, hour: 12, weekday: 7
```

Math

```swift
    date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)! + 2.hours + 2.minutes
    print(date.toString(with: "dd MM yyyy HH:mm:ss")) // 01 01 2000 14:02:00
        
    date = Date(year: 2000, month: 1, day: 1, hour: 12, minute: 0, second: 0)! - 2.months - 3.minutes
    print(date.toString(with: "dd MM yyyy HH:mm:ss")) // 01 11 1999 11:57:00
```

## Contribution
Feel free to contribute by doing `fork` and `Pull Request`


