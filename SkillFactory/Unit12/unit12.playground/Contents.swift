import UIKit
import Foundation

//protocol SomeProtocol{
//    var someproperty: String? { get set }
//}
//class SomeClass:SomeProtocol {
//    var someproperty: String?
//}

//protocol Dog{
//    var paws : Int { get }
//    var ears : Int { get }
//}
//
//class Dachshund: Dog{
//    var ears: Int = 2
//    var paws: Int = 4
//}
//
//let knopka = Dachshund()
//print(knopka.paws)
//
//knopka.paws = 6
//print(knopka.paws)
//
//protocol Dog {
//    var paws: Int { get }
//    var weight: Float { get set }
//    var commands: [String] { get set }
//}

//class Dachshund: Dog {
//    var paws: Int = 4
//}

//let knopka = Dachshund ( )
//knopka.paws = 6
//print (knopka .paws)

//let knopkas: Dog = Dachshund ( )
//knopkas.paws = 6
//print (knopkas.paws)

//class Dachshund: Dog {
//    private var numPaws: Int
//
//    var paws: Int {
//        return numPaws
//    }
//    init(_ np: Int){
//        numPaws = np
//    }
//}
//
//let knopkas = Dachshund (4)
//knopkas.paws = 6
//print (knopkas.paws)

//
//class Dachshund: Dog {
//    private (set) var paws: Int = 4
//}
//
//let knopkas = Dachshund ()
//knopkas.paws = 6
//print (knopkas.paws)
//
//class Bassethound: Dog {
//    private (set) var paws: Int = 4
//    var weight: Float = 36.5
//    var commands: [String] = ["Sidet", "Mesto", "Fuuu"]
//}
//
//let life = Bassethound()
//life.weight = 40.2
//life.commands.append("JRAT")

protocol SquadCanids{
    var ears: Int { get }
    var eyes: Int { get }
    var tail: Int { get }
    var fangs: Bool { get }
}

protocol Bark{
    var dogBark: Bool { get }
}

protocol Commands{
    var dogCommands: [String] { get set }
}

class Dog: SquadCanids{
    private (set) var ears: Int = 2
    private (set) var eyes: Int = 2
    private (set) var tail: Int = 1
    private (set) var fangs: Bool = true
    
    init(_ dogNickname: String){
        self.dogNickname = dogNickname
    }
    var dogNickname: String
    
    var nickname: String{
        get{
            return dogNickname
        }
        set{
            dogNickname = newValue
        }
    }
}

class BassetHound: Dog, Bark, Commands{
    private (set) var dogBark: Bool = true
    var dogCommands: [String]
    
    init(_ dogNickname: String, commands: [String]){
        dogCommands = commands
        super.init(dogNickname)
    }
}

let life = BassetHound("Life", commands: ["Sidet", "Lapu", "JRAT", "FUUUUUU"])
print(
"""
Пёс по имени \(life.dogNickname) умеет лаять: \(life.dogBark),
у него здоровые зубы: \(life.fangs),
  имеет \(life.tail) хвост,
  \(life.eyes) глаза,
  \(life.ears) уха,
  знает команды: \(life.dogCommands).
  По заключению врача пес здоров!!
"""
)


protocol Car{
    var model: String {get set}
    var speed: Int {get set}
    
    init(_ model: String, _ speed: Int)
    
    func Print()
}
extension Car{
    func Print() {
        print("""
                This is BMW \(self.model).
                Max speed is \(self.speed).
            """)
    }
}

class BMW: Car{
    var model: String
    var speed: Int
    required init(_ model: String, _ speed: Int) {
        self.model = model
        self.speed = speed
    }
}

let x5m = BMW("X5M", 280)
x5m.Print()

protocol MyDelegate{
    func changeText(_ text: String)
}

class General:MyDelegate{
    var generalText = "Hello world!"
    
    func changeText(_ text: String) {
        generalText = text
    }
}
class Secondary{
    var delegate: MyDelegate!
}

let general = General()
print(general.generalText)

let secondary = Secondary()
secondary.delegate = general


secondary.delegate?.changeText("Pussy")

print(general.generalText)

protocol SomeMyDelegate{
    func printSomeText(someText: String)
}

class SomeClassImplementsDelegate: SomeMyDelegate{
    func printSomeText(someText: String) {
        print(someText + "Class Impliments Delegate")
    }
}

class SomeClassUsingDelegate{
    var delegate: SomeMyDelegate!
    
    func simulateAction(text: String){
        delegate.printSomeText(someText: text)
    }
}
let implementsDelegate = SomeClassImplementsDelegate()
let usingDelegate = SomeClassUsingDelegate()

usingDelegate.delegate = implementsDelegate

usingDelegate.simulateAction(text: "I am posting new text ")
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
protocol FeedDeliveryDelegate{
    func feedDeliveryByAddres(addres: String, house: String, flat: String)
    func feedDeliveryTime(date: String, time: String)
    func ordered(feed: DogFeed?, toys: DogToys?)
    func order()
}

enum DogToys: String{
    case ball = "Big ball"
    case smaleball = "Small ball"
    case softbone = "Soft bone"
    case stick = "Lovely stick"
    case rope = "Ship rope"
}

enum DogFeed: String{
    case chappi = "Chappi"
    case pedigree = "Pedigree"
    case royalcanin = "Royal Canin"
    case porrige = "Porrige"
}

class FeedShopHappyDog: FeedDeliveryDelegate{
    var addres: String = ""
    var house: String = ""
    var flat: String = ""
    var date: String = ""
    var time: String = ""
    var orderedFeed: [DogFeed?] = []
    var orderedToys: [DogToys?] = []
    
    func feedDeliveryByAddres(addres: String, house: String, flat: String) {
        self.addres = addres
        self.house = house
        self.flat = flat
    }
    
    func feedDeliveryTime(date: String, time: String) {
        self.date = date
        self.time = time
    }
    
    func ordered(feed: DogFeed?, toys: DogToys?) {
        if feed != nil{
            self.orderedFeed.append(feed)
        }
        if toys != nil{
            self.orderedToys.append(toys)
        }
    }
    
    func order(){
        var feedOrder: String = ""
        var toysOrder: String = ""
        if !orderedFeed.isEmpty{
            for index in orderedFeed{
                feedOrder += index!.rawValue + ", "
            }
            feedOrder.remove(at: feedOrder.index(feedOrder.endIndex, offsetBy: -2))
        }
        if !orderedToys.isEmpty{
            for index in orderedToys{
                toysOrder += index!.rawValue + ", "
            }
            toysOrder.remove(at: toysOrder.index(toysOrder.endIndex, offsetBy: -2))
        }
        print("Yout addres is: \(self.addres), \(self.house), #\(self.flat)")
        print("Your delivery will come to you \(self.date) at \(self.time)")
        print("You order feed: \(feedOrder)")
        print("You order toys: \(toysOrder)")
        
    }
}

class WebsiteForOrderingFeedShopHappyDog{
    var delegate: FeedDeliveryDelegate?
    func userSelectsPurchasesDogGoodsStore(feed: DogFeed?, toys: DogToys?){
        if feed != nil{
            delegate?.ordered(feed: feed,toys: nil)
        }
        if toys != nil{
            delegate?.ordered(feed: nil,toys: toys)
        }
    }
    func userEnteredAddres(yourAddres: String, house:String, flat: String){
        delegate?.feedDeliveryByAddres(addres: yourAddres, house: house, flat: flat)
    }
    func userEnteredDeliveryTime(deliveryDate: String, timeOfDelivery: String){
        delegate?.feedDeliveryTime(date: deliveryDate, time: timeOfDelivery)
    }
    func userAcceptOrder(){
        delegate?.order()
    }
}

let dogShop = FeedShopHappyDog()
let siteShop = WebsiteForOrderingFeedShopHappyDog()
siteShop.delegate = dogShop
siteShop.userEnteredAddres(yourAddres: "Novoe shosse", house: "9 k 1", flat: "92")
siteShop.userEnteredDeliveryTime(deliveryDate: "15.03.2023", timeOfDelivery: "18:00")
siteShop.userSelectsPurchasesDogGoodsStore(feed: DogFeed.chappi, toys: nil)
siteShop.userSelectsPurchasesDogGoodsStore(feed: nil, toys: DogToys.rope)
siteShop.userSelectsPurchasesDogGoodsStore(feed: DogFeed.royalcanin, toys: DogToys.stick)
siteShop.userAcceptOrder()
