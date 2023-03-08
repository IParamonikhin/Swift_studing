//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

enum ArithmeticExpressions{
//    case addition(Float, Float)
//    case substraction(Float,Float)
//    case multiolication(Float,Float)
//    case division(Float,Float)
    case number (Float)
    /* Проасоциированные члены перечисления, будут использоваться рекурсивно,
    для этого мы указываем ключевое слово indirect. В качестве аргумента принимают само перечисление (Arithmetic) ,
    но мы, указали его при помощи ключевого слова
    Self - указатель, на конкретное перечисление/класс/структуру.
    */
    indirect case addition (Self, Self)
    indirect case subtraction (Self, Self)
    indirect case division(Self, Self)
    indirect case multiplication (Self, Self)
    // Функция выполняющая вычисления.
    func expression (exp: ArithmeticExpressions) -> Float {
    // При помощи switch программа выбирает то вычисление которое требуется.
    switch exp {
        case let.number (value):
            return value
    // Сложение.
        case let.addition (numberOne, numberTwo):
            return self.expression(exp: numberOne) + self.expression (exp: numberTwo)
    // Вычитание.
        case let.subtraction (numberOne, numberTwo):
            return self.expression(exp: numberOne) - self.expression (exp: numberTwo)
    // Умножение.
        case let.division (numberOne, numberTwo):
            return self.expression(exp: numberOne) / self.expression (exp: numberTwo)
    // Деление.
        case let.multiplication (numberOne, numberTwo):
            return self.expression(exp: numberOne) * self.expression (exp: numberTwo)
    }
    //
//    func computation(arithmetic: ArithmeticExpressions) -> Float{
//        switch arithmetic{
//        case let.addition(numberOne, NumberTwo):
//            return numberOne + NumberTwo
//        case let.substraction(numberOne, NumberTwo):
//            return numberOne - NumberTwo
//        case let.multiolication(numberOne, numberTwo):
//            return numberOne * numberTwo
//        case let.division(numberOne, NumberTwo):
//            return numberOne / NumberTwo
//        }
    }
}


    var auddition = ArithmeticExpressions.subtraction(.number(6), .multiplication(.number(10), .number(1)))
auddition.expression(exp: auddition)




var fruits: [String] = ["apple", "banana", "orange", "pineapple"]
print(fruits[0])
var last = fruits.last
print(last ?? "Fail")
fruits.append("cocoa")
fruits.insert("pear", at: 1)
print(fruits)
fruits += ["mango", "cactus"]
print(fruits)
fruits.removeLast(3)
print(fruits)
fruits.dropLast(2)
print(fruits)

let val = [2.0, 3.1, 5.2, 0.0, 12.0]
let sqrt = val.map{$0 * $0}
print(val)
print(sqrt)

let shortFruits = fruits.filter{$0.count <= 5}
let fruitsWithP = fruits.filter{$0.contains("p")}
print(shortFruits)
print(fruitsWithP)
print("\(fruits.dropLast(fruits.count - 1))")

var numbers = [1, -3, 6, 1, -3, 4, 9, 13, 653, 11, 666, 0, -12, -3223]
var filteredNumbers = numbers.drop(while: {$0 < 11})
print(filteredNumbers) // [1, -3]

print("\(fruits.sorted(by:>))")


var numb: Set<Int> = [1,4,34,54,333,2345,56432,5]
var numbs: Set = [ 344,5432,2345, 333,1,5]
print(numb.intersection(numbs))
print(numb.union(numbs))
print(numb.subtracting(numbs))
print(numbs.subtracting(numb))
print(numb.symmetricDifference(numbs))

print(numb.sorted(by: <))
print(numbs.sorted(by: <))
print(numb.sorted(by: >))
print(numbs.sorted(by: >))


print(numb.intersection(numbs).sorted())
print(numb.union(numbs).sorted())
print(numb.subtracting(numbs).sorted())
print(numbs.subtracting(numb).sorted())
print(numb.symmetricDifference(numbs).sorted())

let ids: Set<String> = ["1213-2134-5423-4532", "1394-2574-4569-3912", "3982-2577-3375-4314", "3243-2357-3267-4567", "1332-4237-8888-6653", "3333-8131-7225-0990"]
let securityIds: Set<String> = ["1213-2134-5423-4532", "1394-2574-4569-3912", "3131-2145-5676-5677", "1332-4237-8888-6653", "3333-8131-7225-0990"]
print(ids.symmetricDifference(securityIds).sorted())


//========================================================================================//

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
arrayMonthWithDays.forEach{print($0.days)}
arrayMonthWithDays.forEach{print("\($0.month) \($0.days)")}

for i in (0...arrayMonthWithDays.count - 1).reversed() {
    print("\(arrayMonthWithDays[i].1)")
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
