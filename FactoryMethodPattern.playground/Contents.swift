import UIKit


protocol TextValidation {
    var regExfindMatchString: String { get }
    var validationMessage: String { get }
}

//확장
extension TextValidation{
    var regExMatchingString: String{
        get {
            return regExfindMatchString + "$"
        }
    }
    
    func validateString(str: String) -> Bool{
        if let _ = str.range(of: regExfindMatchString, options: .regularExpression){
            return true
        } else {
            return false
        }
    }
    
    func getMatchingString(str: String) -> String? {
        if let newMatch = str.range(of: regExfindMatchString, options: .regularExpression){
            return String(str[newMatch])
        } else {
            return nil
        }
    }
}

//TextValidation 프로토콜을 따르는 세가지 타입
class AlphaValidation: TextValidation {
    static let sharedInstance = AlphaValidation()
    private init() {}
    let regExfindMatchString: String = "^[a-zA-Z]{0,10}"
    let validationMessage: String = "Can only contain Alpha characters"
}

class AlphaNumericValidation: TextValidation {
    static let sharedInstance = AlphaNumericValidation()
    private init() {}
    let regExfindMatchString: String = "^[a-zA-Z0-9]{0,10}"
    let validationMessage: String = "Can only contain Alpha Numeric characters"
}

class NumbericValidation: TextValidation{
    static let sharedInstance = NumbericValidation()
    private init() {}
    let regExfindMatchString = "^[0-9]{0,10}"
    let validationMessage: String = "Display name can contain a maximum of 15 Alphanumeric Characters"
}

//유효성 클래스를 사용하기 위해서는 유효성을 확인하고자 하는 문자열에 기초해 어떠한 클래스를 사용할지를 결정하는 방법이 필요
func getValidator(alphaCharacters: Bool, numericCharacters: Bool) -> TextValidation? {
    if alphaCharacters && numericCharacters {
        return AlphaNumericValidation.sharedInstance
    } else if alphaCharacters && !numericCharacters {
        return AlphaValidation.sharedInstance
    } else if !alphaCharacters && numericCharacters {
        return NumbericValidation.sharedInstance
    } else {
        return nil
    }
}

var str = "abc123"
var validator1 = getValidator(alphaCharacters: true, numericCharacters: false)
print("String validated: \(validator1?.validateString(str: str))")

var validator2 = getValidator(alphaCharacters: true, numericCharacters: true)
print("String validated: \(validator2?.validateString(str: str))")
