import UIKit


UserDefaults.standard
//UserDefaults.standard.value(forKey: String)
//UserDefaults.standard.string(forKey: String)
//UserDefaults.standard.bool(forKey: String)
//UserDefaults.standard.float(forKey: String)

let defaultValue = UserDefaults.standard
defaultValue.set(5.14, forKey: "Number")
let myValue = defaultValue.float(forKey: "Number")

defaultValue.set(8, forKey: "Digit")
defaultValue.set(false, forKey: "LightIsOn")
defaultValue.set("iOS Trainee", forKey: "MyStatus")
defaultValue.set([6, 11, 901], forKey: "Digits")
defaultValue.set (7.904563290346863, forKey: "LongNum")


let myValue1 = defaultValue.integer(forKey: "Digit")
let myValue2 = defaultValue.bool(forKey: "LightIsOn")
let myValue3 = defaultValue.string(forKey: "MyStatus")
let myValue4 = defaultValue.array(forKey: "Digits")
let myValue5 = defaultValue.double(forKey: "LongNum")
