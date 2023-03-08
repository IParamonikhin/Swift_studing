let player = ("Miranchuk", "Anton", 10)
let playerTwo = (surname: "Barinov", firstname: "Dmitriy", number: 8)
let playerTree = (surname: "Guilerme", firstname: "Marinato", number: 1)
let (surname, firstname, number) = player

print("\t \(firstname) \(surname) number \(number) \u{26bd}")
print("\t \(playerTwo.surname) \(playerTwo.firstname) number \(playerTwo.number) \u{26bd}")
print("\t \(playerTree.0) \(playerTree.1) number \(playerTree.2) \u{26bd}")

let daysInMonth: Array<Int> = [31,28,31,30,31,30,31,31,30,31,30,31]
print("\r")
daysInMonth.count
daysInMonth[0]
daysInMonth.forEach{print($0)}
let monthNames: Array<String> = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
print("\r")
for index in 0...daysInMonth.count - 1{
    print("\(monthNames[index]) \(daysInMonth[index])")
}

let arrayMonthWithDays: [(month:String,days:Int)] = [("Январь",31), ("Февраль",28), ("Март",31), ("Апрель",30), ("Май",31), ("Июнь",30), ("Июль",31), ("Август",31), ("Сентябрь",30), ("Октябрь",31), ("Ноябрь",30), ("Декабрь",31)]

print("\r")
arrayMonthWithDays.forEach{print($0.month)}
print("\r")
arrayMonthWithDays.forEach{print($0.days)}
print("\r")
arrayMonthWithDays.forEach{print("\($0.month) \($0.days)")}
print("\r")

for i in (0...arrayMonthWithDays.count - 1).reversed() {
    print("\(arrayMonthWithDays[i].month) \(arrayMonthWithDays[i].days)")
}
print("\r")


let data = ("Март", 7)

func calculateDaysLeft (month: String, day: Int) -> Int{
    var year = 365
    for i in 0...arrayMonthWithDays.count-1{
        if(arrayMonthWithDays[i].month != month){
            year -= arrayMonthWithDays[i].days
        }
        else
        {
            year -= day
            break
        }
    }
    return year
}
print(calculateDaysLeft(month: data.0, day: data.1))


print("\r")
var students: [String : Int] = ["Ivanov Petr" : 2, "Semenov Denis" : 2, "Shunin Nikita" : 3, "Bessonov Kirill" : 5, "Slepakov Semen" : 4, "Borisova Vladlena" : 1]
students.updateValue(students["Semenov Denis"]! + 1, forKey: "Semenov Denis")

for (student, grade) in students {
    if (grade > 2){
        print("Congratulation \(student), you have nice grade!")
    }
    else{
        print("Shame on you \(student), you must retake!")
    }
}

print("\r")
students["Urgant Ivan"] = 4
students["Muzichenko Uri"] = 2
students.removeValue(forKey: "Shunin Nikita")

func AvaregeGrade ()->Double{
    var gradeSumm = 0
    for (_, grade) in students {
        gradeSumm += grade
    }
    return Double(gradeSumm) / Double(students.count)
}
print(AvaregeGrade())
