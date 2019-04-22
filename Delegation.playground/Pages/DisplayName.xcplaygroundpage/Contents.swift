import UIKit

protocol DisplayNameDlegate {
    func displayName(name: String)
}


struct Person{
    var displayNameDelegate : DisplayNameDlegate
    
    //didSet은 프로퍼티 옵저버 : 값이 변경됨을 인지한다.
    var firstName = "" {
        didSet{
            displayNameDelegate.displayName(name: getFullName())
        }
    }
    
    var lastName = ""{
        didSet{
            displayNameDelegate.displayName(name: getFullName())
        }
    }
    
    init(displayNameDelegate: DisplayNameDlegate){
        self.displayNameDelegate = displayNameDelegate
    }
    
    func getFullName() -> String{
        return "\(firstName) \(lastName)"
    }
}


struct MyDisplayNameDelegate: DisplayNameDlegate{
    func displayName(name: String) {
        print("Name: \(name)")
    }
}

//델리게이트 사용
var displayDelegate = MyDisplayNameDelegate()
var person = Person(displayNameDelegate: displayDelegate)
person.firstName = "Jo"
person.lastName = "wonik"



