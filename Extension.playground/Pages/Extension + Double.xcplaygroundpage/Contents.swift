//: [Previous](@previous)

import Foundation
import UIKit

//소수점 두자리로 반올림하고 통화기호 추가
extension Double{
    func currencyString() -> String{
        let divisor = pow(10.0, 2.0)
        let num = round(self * divisor).rounded
        return "$\(num)"
    }
}

print(4.0.currencyString())
//: [Next](@next)
