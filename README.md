# Date Manager
Here I collect the main methods I regularly use to handle Date in one manager

  
## Usage

### Convert String <-> Date

```swift
let date = getDateFromString(dateString : "1992-04-28", format : "yyyy-MM-dd")

let dateString = getStringFromDate(date : date, format : "yyyy-MM-dd")
```

### Convert to Time

```swift

let time = getTimeFromString(dateString : "1992-04-28 13:30:00", format : "yyyy-MM-dd HH:mm:ss", timeFormat : "hh:mm a", amSymbol : "AM", pmSymbol : "PM")

```

### Get Specific Component 

```swift

let day = getComponentFromDate(dateString: "1992-04-28 13:30:00", format : "yyyy-MM-dd HH:mm:ss", component : .day)

let second = getComponentFromDate(dateString: "1992-04-28 13:30:00", format : "yyyy-MM-dd HH:mm:ss", component : .second)

let weekday = getComponentFromDate(dateString: "1992-04-28 13:30:00", format : "yyyy-MM-dd HH:mm:ss", component : .weekday)

let month = getCurrentComponent(component : .month)

```

### Other Methods

```swift

let isItToday = isItToday(dateString : "2018-04-28 13:30:00", format : "yyyy-MM-dd HH:mm:ss") 

let numOfWeeks = numOfWeeks(in: 2018)

let chatTimestamp = chatTimestamp("2018-04-28 13:30:00")

```





