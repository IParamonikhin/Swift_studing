import Foundation

// Абстракция данных пользователя
protocol UserData {
    var userName: String { get }               //Имя пользователя
    var userCardId: String { get }             //Номер карты
    var userCardPin: Int { get }               //Пин-код
    var userPhone: String { get }              //Номер телефона
    var userCash: Float { get set }            //Наличные пользователя
    var userBankDeposit: Float { get set }     //Банковский депозит
    var userPhoneBalance: Float { get set }    //Баланс телефона
    var userCardBalance: Float { get set }     //Баланс карты
}

enum UserActions {
    case checkBalance
    case withdrawal(withdraw: Float)
    case refill(refill: Float)
    case topUpPhoneBalance(phone: String, pay: Float)
}

// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
    case balanceRequest = "Запрос баланса"
    case withdraw = "Снятие наличных"
    case refill = "Пополнение наличными"
    case mobileRefill = "Пополнение телефона"
}
 
// Способ оплаты/пополнения наличными, картой или через депозит
enum PaymentMethod {
    case card
    case cash
    case deposit
}

// Тексты ошибок
enum TextErrors: String {
    case notEnoughCashMoney = "Не достаточно наличных"
    case notEnoughCardMoney = "Не достаточно денег на карте"
    case notEnoughDepositMoney = "Не достаточно денег на депозите"
    case phoneNotValid = "Не правильный номер телефона"
    case cardIdNotValid = "Не правильный номер карты"
    case cardPinNotValid = "Не правильный PIN"
    case nilAccountBalance = "Не указан счет для вывода баланса"
    case wrongAccountWithdrawal = "Не правильный счет для снятия наличных"
    case nilAccountWithdrawal = "Не выбран счет для снятия наличных"
    case wrongAccountRefill = "Не правильный счет для зачисления наличных"
    case nilAccountRefill = "Не выбран счет для зачисления наличных"
    case wrongAccountRefillPhone = "Не правильный счет для пополнения телефона"
    case nilAccountRefillPhone = "Не выбран счет для пополнения телефона"
    case wrongPay = "Сумма пополнения не может быть равна 0"
}

// Протокол по работе с банком предоставляет доступ к данным пользователя зарегистрированного в банке
protocol BankApi {
    func showUserCardBalance()
    func showUserDepositBalance()
    func showUserPhoneBalance()
    func showUserCash()
    func showUserToppedUpMobilePhoneCash(cash: Float)
    func showUserToppedUpMobilePhoneCard(card: Float)
    func showWithdrawalCard(cash: Float)
    func showWithdrawalDeposit(cash: Float)
    func showTopUpCard(cash: Float)
    func showTopUpDeposit(cash: Float)
    func showError(error: TextErrors)
 
    func checkUserPhone(phone: String) -> Bool
    func checkMaxUserCash(cash: Float) -> Bool
    func checkMaxUserDeposit(deposit: Float) -> Bool
    func checkMaxUserCard(withdraw: Float) -> Bool
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool
 
    mutating func topUpPhoneBalanceCash(pay: Float)
    mutating func topUpPhoneBalanceCard(pay: Float)
    mutating func getCashFromDeposit(cash: Float)
    mutating func getCashFromCard(cash: Float)
    mutating func putCashDeposit(topUp: Float)
    mutating func putCashCard(topUp: Float)
}

struct User: UserData {
    var userName: String
    var userCardId: String
    var userCardPin: Int
    var userPhone: String
    var userCash: Float
    var userBankDeposit: Float
    var userPhoneBalance: Float
    var userCardBalance: Float
}

class Bank: UserData, BankApi{
    var userName: String            //Имя пользователя
    var userCardId: String          //Номер карты
    var userCardPin: Int            //Пин-код
    var userPhone: String           //Номер телефона
    var userCash: Float             //Наличные пользователя
    var userBankDeposit: Float      //Банковский депозит
    var userPhoneBalance: Float     //Баланс телефона
    var userCardBalance: Float      //Баланс карты
    
    init( user: UserData) {
        self.userName = user.userName
        self.userCardId = user.userCardId
        self.userCardPin = user.userCardPin
        self.userPhone = user.userPhone
        self.userCash = user.userCash
        self.userBankDeposit = user.userBankDeposit
        self.userPhoneBalance = user.userPhoneBalance
        self.userCardBalance = user.userCardBalance
        print("""
                Создан пользователь \(self.userName)
                    Карта: \(self.userCardId)
                    Телефон: \(self.userPhone)
                    Баланс:
                            Депозит - \(self.userBankDeposit)
                            Карта - \(self.userCardBalance)
                            Наличные - \(self.userCash)
                            Телефон - \(self.userPhoneBalance)
                
                """)
    }
    
    func showUserCardBalance(){
        print("Баланс карты: \(self.userCardBalance)")
    }
    func showUserDepositBalance(){
        print("Баланс депозита: \(self.userBankDeposit)")
    }
    func showUserPhoneBalance(){
        print("Баланс депозита: \(self.userBankDeposit)")
    }
    func showUserCash(){
        print("Наличные: \(self.userCash)")
    }
    func showUserToppedUpMobilePhoneCash(cash: Float){
        print("Мобильный телефон пополнен на \(cash) наличными")
    }
    func showUserToppedUpMobilePhoneCard(card: Float){
        print("Мобильный телефон пополнен на \(card) с карты")
    }
    func showWithdrawalCard(cash: Float){
        print("\(cash) снято с карты")
    }
    func showWithdrawalDeposit(cash: Float){
        print("\(cash) снято с  депозита")
    }
    func showTopUpCard(cash: Float){
        print("Карта пополнена на \(cash)")
    }
    func showTopUpDeposit(cash: Float){
        print("Депозит пополнена на \(cash)")
    }
    func showError(error: TextErrors){
        print(error.rawValue)
    }
 
    func checkUserPhone(phone: String) -> Bool{
        if self.userPhone == phone{
            return true
        }
        else{
            showError(error: TextErrors.phoneNotValid)
            return false
        }
    }
    func checkMaxUserCash(cash: Float) -> Bool{
        if self.userCash >= cash{
            return true
        }
        else{
            showError(error: TextErrors.notEnoughCashMoney)
            return false
        }
    }
    func checkMaxUserCard(withdraw: Float) -> Bool{
        if self.userCardBalance >= withdraw{
            return true
        }
        else{
            showError(error: TextErrors.notEnoughCardMoney)
            return false
        }
    }
    func checkMaxUserDeposit(deposit: Float) -> Bool{
        if self.userBankDeposit >= deposit{
            return true
        }
        else{
            showError(error: TextErrors.notEnoughDepositMoney)
            return false
        }
    }
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool{
        if self.userCardId == userCardId && self.userCardPin == userCardPin{
            return true
        }
        else {
            if self.userCardId != userCardId{
                showError(error: TextErrors.cardIdNotValid)
            }
            if self.userCardPin != userCardPin{
                showError(error: TextErrors.cardPinNotValid)
            }
            return false
        }
    }
    
    func topUpPhoneBalanceCash(pay: Float){
        self.userCash -= pay
        self.userPhoneBalance += pay
    }
    func topUpPhoneBalanceCard(pay: Float){
        self.userCardBalance -= pay
        self.userPhoneBalance += pay
    }
    func getCashFromDeposit(cash: Float){
        self.userBankDeposit -= cash
        self.userCash += cash
    }
    func getCashFromCard(cash: Float){
        self.userCardBalance -= cash
        self.userCash += cash
    }
    func putCashDeposit(topUp: Float){
        self.userCash -= topUp
        self.userBankDeposit += topUp
    }
    func putCashCard(topUp: Float){
        self.userCash -= topUp
        self.userCardBalance += topUp
    }
    
}
// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {
    private let userCardId: String
    private let userCardPin: Int
    private var someBank: BankApi
    private let action: UserActions = .checkBalance
    private let paymentMethod: PaymentMethod? = nil
 
    init(userCardId: String, userCardPin: Int, someBank: BankApi){//, action: UserActions, paymentMethod: PaymentMethod? = nil) {
        self.userCardId = userCardId
        self.userCardPin = userCardPin
        self.someBank = someBank
        if self.someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin){
            print("""
                    Вход выполнен
                    
                    """)
        }
//        self.action = action
//        self.paymentMethod = paymentMethod
 
 
//        sendUserDataToBank(userCardId, userCardPin, action, paymentMethod)
  }
 
 
  public final func sendUserDataToBank(_ userCardId: String, _ userCardPin: Int, _ actions: UserActions, _ payment: PaymentMethod?) {
      if self.someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin){
          switch actions{
          case .checkBalance:
              print(DescriptionTypesAvailableOperations.balanceRequest.rawValue)
              switch payment{
              case .card:
                  self.someBank.showUserCardBalance()
              case .deposit:
                  self.someBank.showUserDepositBalance()
              case .cash:
                  self.someBank.showUserCash()
              case .none:
                  self.someBank.showError(error: .nilAccountBalance)
              }
          case let .withdrawal(withdraw):
              print(DescriptionTypesAvailableOperations.withdraw.rawValue)
              if withdraw != 0{
                  switch payment{
                  case .card:
                      if self.someBank.checkMaxUserCard(withdraw: withdraw){
                          self.someBank.getCashFromCard(cash: withdraw)
                          self.someBank.showWithdrawalCard(cash: withdraw)
                          self.someBank.showUserCardBalance()
                          self.someBank.showUserCash()
                      }
                  case .deposit:
                      if self.someBank.checkMaxUserDeposit(deposit: withdraw){
                          self.someBank.getCashFromDeposit(cash: withdraw)
                          self.someBank.showWithdrawalDeposit(cash: withdraw)
                          self.someBank.showUserDepositBalance()
                          self.someBank.showUserCash()
                      }
                  case .cash:
                      self.someBank.showError(error: .wrongAccountWithdrawal)
                  case .none:
                      self.someBank.showError(error: .nilAccountWithdrawal)
                  }
              }
              else{
                  self.someBank.showError(error: .wrongPay)
              }
          case .refill(refill: let refill):
              print(DescriptionTypesAvailableOperations.refill.rawValue)
              if refill != 0{
                  switch payment{
                  case .card:
                      if self.someBank.checkMaxUserCard(withdraw: refill){
                          self.someBank.putCashCard(topUp: refill)
                          self.someBank.showTopUpCard(cash: refill)
                          self.someBank.showUserCardBalance()
                          self.someBank.showUserCash()
                      }
                  case .deposit:
                      if self.someBank.checkMaxUserCash(cash: refill){
                          self.someBank.putCashDeposit(topUp: refill)
                          self.someBank.showTopUpDeposit(cash: refill)
                          self.someBank.showUserDepositBalance()
                          self.someBank.showUserCash()
                      }
                  case .cash:
                      self.someBank.showError(error: .wrongAccountRefill)
                  case .none:
                      self.someBank.showError(error: .nilAccountRefill)
                  }
              }
              else{
                  self.someBank.showError(error: .wrongPay)
              }
          case .topUpPhoneBalance(phone: let phone, pay: let pay):
              print(DescriptionTypesAvailableOperations.mobileRefill.rawValue)
              if self.someBank.checkUserPhone(phone: phone){
                  if pay != 0{
                      switch payment{
                      case .card:
                          if self.someBank.checkMaxUserCard(withdraw: pay){
                              self.someBank.topUpPhoneBalanceCard(pay: pay)
                              self.someBank.showUserToppedUpMobilePhoneCard(card: pay)
                              self.someBank.showUserPhoneBalance()
                              self.someBank.showUserCardBalance()
                          }
                      case .cash:
                          if self.someBank.checkMaxUserCash(cash: pay){
                              self.someBank.topUpPhoneBalanceCash(pay: pay)
                              self.someBank.showUserToppedUpMobilePhoneCash(cash: pay)
                              self.someBank.showUserPhoneBalance()
                              self.someBank.showUserCash()
                          }
                      case .deposit:
                          self.someBank.showError(error: .wrongAccountRefillPhone)
                      case .none:
                          self.someBank.showError(error: .nilAccountRefillPhone)
                      }
                  }
                  else{
                      self.someBank.showError(error: .wrongPay)
                  }
              }
          }
          print("\r\n")
      }
  }
}


let Ivan: UserData = User(
    userName: "Иван",
    userCardId: "8888",
    userCardPin: 1234,
    userPhone: "999",
    userCash: 1000,
    userBankDeposit: 1000,
    userPhoneBalance: 1000,
    userCardBalance: 1000
)

var testBank = Bank(user: Ivan)

var test = ATM(userCardId: "8888", userCardPin: 1234, someBank: testBank)//, action: .checkBalance, paymentMethod: .card)

test.sendUserDataToBank("8888", 1234, .checkBalance, .card)
test.sendUserDataToBank("8888", 1234, .checkBalance, .deposit)
test.sendUserDataToBank("8888", 1234, .checkBalance, .cash)

test.sendUserDataToBank("123", 1234, .checkBalance, nil)
test.sendUserDataToBank("8888", 1235, .checkBalance, nil)

test.sendUserDataToBank("8888", 1234, .checkBalance, nil)
test.sendUserDataToBank("8888", 1234, .checkBalance, nil)

test.sendUserDataToBank("8888", 1234, .withdrawal(withdraw: 300), .cash)
test.sendUserDataToBank("8888", 1234, .withdrawal(withdraw: 300), .card)
test.sendUserDataToBank("8888", 1234, .withdrawal(withdraw: 300), .deposit)
test.sendUserDataToBank("8888", 1234, .withdrawal(withdraw: 300), nil)
test.sendUserDataToBank("8888", 1234, .withdrawal(withdraw: 9999), .card)
test.sendUserDataToBank("8888", 1234, .withdrawal(withdraw: 9999), .deposit)

test.sendUserDataToBank("8888", 1234, .refill(refill: 160), .cash)
test.sendUserDataToBank("8888", 1234, .refill(refill: 160), .card)
test.sendUserDataToBank("8888", 1234, .refill(refill: 160), .deposit)
test.sendUserDataToBank("8888", 1234, .refill(refill: 160), nil)

test.sendUserDataToBank("8888", 1234, .topUpPhoneBalance(phone: "999", pay: 123), .cash)
test.sendUserDataToBank("8888", 1234, .topUpPhoneBalance(phone: "999", pay: 123), .card)
test.sendUserDataToBank("8888", 1234, .topUpPhoneBalance(phone: "999", pay: 123), .deposit)
test.sendUserDataToBank("8888", 1234, .topUpPhoneBalance(phone: "999", pay: 123), nil)
test.sendUserDataToBank("8888", 1234, .topUpPhoneBalance(phone: "9996", pay: 123), .cash)
test.sendUserDataToBank("8888", 1234, .topUpPhoneBalance(phone: "999", pay: 9999), .cash)
test.sendUserDataToBank("8888", 1234, .topUpPhoneBalance(phone: "999", pay: 9999), .card)



