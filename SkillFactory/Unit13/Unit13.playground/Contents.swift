import UIKit

enum AutoError : Error{
    case isLost
    case lowBattery
    case brokeAutoDrive
}

var isLost : Bool = false
var lowBattery : Bool = false
var brokeAutoDtive : Bool = false
var batteryCharge = 50

func autoDrive() throws{
    if isLost { throw AutoError.isLost }
    if lowBattery { throw AutoError.lowBattery }
    if brokeAutoDtive { throw AutoError.brokeAutoDrive }
}

do {
    if isLost { throw AutoError.isLost }
    if lowBattery { throw AutoError.lowBattery }
    if brokeAutoDtive { throw AutoError.brokeAutoDrive }
}
catch AutoError.isLost {
    print("Is lost")
}
catch AutoError.lowBattery where batteryCharge < 15  {
    print("Battery is low")
}
catch AutoError.brokeAutoDrive{
    print("Autodrive is broken")
}

//do {
//   try autoDrive()
//}
//catch AutoError.isLost {
//    print("Is lost")
//}
//catch AutoError.lowBattery where batteryCharge < 15 {
//    print("Battery is low")
//}
//catch AutoError.brokeAutoDrive{
//    print("Autodrive is broken")
//}
