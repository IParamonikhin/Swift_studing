//func randomVal ()->Int{
//    var val:Int = Int.random(in: 1...6)
//    return val
//}
//
//var val1 = randomVal()
//var val2 = randomVal()
//var sum = val1 + val2
//print(" \(val1) , \(val2) summa \(sum)")



//var val1:Int = Int.random(in: 1...6)
//var val2:Int = Int.random(in: 1...6)
//var sum = val1 + val2
//print(" \(val1) , \(val2) summa \(sum)")

//func disc(_ a: Int, _ b: Int, _ c: Int)-> Int{
//    var d = b*b - 4*a*c
//    return d
//}
import Foundation
//
//var disc = {(_ a: Double,_ b: Double,_ c: Double)->Void in
//    print("Уравнение ")
//    var d = pow(b, 2) - 4*a*c
//    var sqrtD = sqrt(d)
//    if(d < 0){
//        print("Нет корней")
//    }
//    else if(d == 0){
//        let k = ((b * (-1))/(2*a))
//        print("Корень \(k)")
//    }
//    else{
//        var k1 = ((b * (-1)) + sqrtD) / (2 * a)
//        var k2 = ((b * (-1)) - sqrtD) / (2 * a)
//        print("Два корня! Корень 1: \(k1),корень 2: \(k2)")
//    }
//
//}
//
//// 36x^4 - 18x + 3
//disc(1, -6, 9)
//
//var pifagor = {(_ a: Double, _ b: Double)-> Void in
//    var c = sqrt(pow(a, 2) + pow(b, 2))
//    print("Гипотенуза равна \(c)")
//
//}
//
//pifagor(36, 36)
//let pi = 3.141592653589793238462643383279502884197
//var sphere = {(_ r: Double)-> Void in
//    let s = pi * pow(r, 2)
//    let p = 2 * pi * r
//    print("Длина окружности = \(p). Площадь окружности = \(s)")
//}
//sphere(1)
//
//func bones ()->(bone1: Int, bone2 : Int, sum: Int){
//    var val1:Int = Int.random(in: 1...6)
//    var val2:Int = Int.random(in: 1...6)
//    return (val1, val2, (val1 + val2))
//}
//var bone = bones()


//print("На костях выпало \(bone.bone1) и \(bone.bone2). В сумме \(bone.sum)")


class MyCar {
    var gas : Int
    
    init(gas : Int){
        self.gas = gas
    }
    
    func gasLevel(){
        if(self.gas == 0){
            print("Kr kr kr kr")
            print("Awful! my car is dead, i won't make it to work on time!")
        }
        else{
            print("Vrum vrum vrum vrum")
            print("Excellently my car is still alive! I won't be late for work")
        }
    }
}

var myCar = MyCar(gas: 10)
var myCarRed = MyCar(gas: 0)
myCar.gasLevel()
myCarRed.gasLevel()

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index // видите? Сабскрипт не будет работать без этого поля
    }
}
let firstNumber = 3
let secondNumber = 10
let threeTimesTable = TimesTable(multiplier: firstNumber) // а вот и наша зависимость на практике
print("\(firstNumber) умножить на \(secondNumber) будет \(threeTimesTable[10])")


class Student{
    var name : String
    var university : String
    var facultative : String
    var averegeGrade : Double
    
    init (name : String, university : String, facultative : String, averegeGrade : Double){
        self.name = name
        self.university = university
        self.facultative = facultative
        self.averegeGrade = averegeGrade
    }
    
    func printStudentData(){
        print("Student \(self.name) from \(self.university) \(self.facultative) hase average rating \(self.averegeGrade)")
    }
}

var mark = Student(name: "Mark", university: "MSU", facultative: "Eco", averegeGrade: 10.4)
var ivan = Student(name: "Ivan", university: "MSUPI", facultative: "PR-101", averegeGrade: 12.3)

mark.printStudentData()
ivan.printStudentData()


var text1 : String? = "Hello "
var text2 : String? = "World!"
var textsumm = text1! + text2!
