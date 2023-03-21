import UIKit

//    1    //
enum ServerError : Error{
    case error400
    case error404
    case error500
}

var error = 400


do {
    if error == 400 { throw ServerError.error400 }
    if error == 404 { throw ServerError.error404 }
    if error == 500 { throw ServerError.error500 }
}
catch ServerError.error400 {
    print("Error 400!")
}
catch ServerError.error404  {
    print("Error 404!")
}
catch ServerError.error500{
    print("Error 500!")
}

//    2    //

func serverError() throws{
    if error == 400 { throw ServerError.error400 }
    if error == 404 { throw ServerError.error404 }
    if error == 500 { throw ServerError.error500 }
}

do {
    try serverError()
}
catch ServerError.error400 {
    print("Error 400!")
}
catch ServerError.error404  {
    print("Error 404!")
}
catch ServerError.error500{
    print("Error 500!")
}

//    3    //

func compareType<T, E> (_ first : T, _ second: E) -> String{
    if type(of: first) == type(of: second){
        return "Yes"
    }
    return "No"
}

print(compareType(12, 12))
print(compareType(12, 12.1))

//    4    //

enum CompareErrors : Error{
    case compareTrue
    case compareFalse
}

func compareTypeError<T, E> (_ first : T, _ second: E) throws{
    if type(of: first) == type(of: second){
        throw CompareErrors.compareTrue
    }
    else{
        throw CompareErrors.compareTrue
    }
}

//    5    //

func compareVariable<T: Comparable> (_ first: T, _ second: T) -> String{
    if first == second{
        return "Yes"
    }
    return "No"
}

print(compareVariable(12, 12))
