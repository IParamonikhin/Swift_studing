////func sayMyName(_ name: String, _ lastname: String){
////    print("Hey \(name) \(lastname)")
////}
//
////sayMyName("Ivan", "Paramonikhin")
//
//func sumTwoNumber(_ x: Int, _ y: Int ){
//    let s = x + y
//    print("Sum \(x) and \(y) = \(s)")
//}
//
//sumTwoNumber(12, 13)
//
//func testInOut ( num: inout Int){
//    num += 1
//}
//
//var t : Int = 0
//testInOut(num : &t)
//testInOut(num : &t)
//testInOut(num : &t)
//print(t)
//
//var myName : String = "Ivan"
//var myLastname : String = "Paramonikhin"
//
//func sayMyName(_ name: inout String, _ lastname: inout String)-> String{
//    name = "Иван"
//    lastname = "Парамонихин"
//    return "Hey \(name) \(lastname)"
//}
//print("Hey \(myName) \(myLastname)")
//print(sayMyName(&myName, &myLastname))
//
//func coffeeAutomat (typeOfCoffee coffee : String, countWater water : Double, userName name : String)-> String{
//    return "Ваши ароматные \(water) мл вкуснейшего \(coffee), \(name)"
//}
//
//print( coffeeAutomat(typeOfCoffee: "Арабика", countWater: 250.0, userName: "Иван"))
//
//func recursiveCounter(number: Int) {
//  if number < 100 {
//    recursiveCounter(number: number + 1)
//    print(number + 1)
//  }
//}
//recursiveCounter(number: 2)
//
//
//func handler(text: String, closure: (String) -> ()) {
//  let concatenateStrings = text + "SkillFactory"
//  closure(concatenateStrings)
//}
//
//handler(text: "Hello "){text in
//    print(text + " World")
//}
//
//
//let employeeSalary: (_ name : String, _ age : UInt, _ jobTitle : String, _ salary: Double) -> (String) = {
//    "Employee \($0), \($1), work as a \($2) with salary of \($3 * 3.14)$ a month"
//}
//print(employeeSalary("Ivan", 32, "engeneer", 300.0))
//
//func textSum (_ t1 : String)-> (String) -> (String) -> String{
//    return{s1 in
//        let textSums = t1 + s1
//        return {textSums + $0}
//    }
//}
//print(textSum("Hi,")(" now I am knowing")("currying"))


var firstName : String = ""
var lastName : String = ""
var age : UInt = 0
var rules : Bool = false

func enterFName (_ firstName : inout String,_ fName : String){
    firstName = fName
}

func enterLName (_ lastName : inout String,_ lName : String){
    lastName = lName
}

func enterAge (_ age : inout UInt,_ nAge : UInt){
    age = nAge
}

func enterRules (_ rules : inout Bool   ,_ isRules : Bool){
    rules = isRules
}

func checkRegister (_ firstName : String)->(Bool){
    if(firstName == ""){
        return false
    }else{
        return true
    }
}
func checkRegister (_ age : UInt)->(Bool){
    if(age == 0){
        return false
    }else{
        return true
    }
}
func checkRegister (_ isRules : Bool)->(Bool){
    if(isRules == false){
        return false
    }else{
        return true
    }
}

func registerUser () -> (Bool){
    if(!checkRegister(lastName)){
       print("Lastname is empty")
        return false
    }
    if(!checkRegister(firstName)){
        print("Firstname is empty")
    }
    if(!checkRegister(age)){
        print("Age is empty")
        return false
    }
    if(!checkRegister(rules)){
        print("No accept rules")
        return false
    }
    return true
}

