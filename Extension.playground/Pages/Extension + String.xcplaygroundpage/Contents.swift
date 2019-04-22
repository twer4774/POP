//: [Previous](@previous)

import Foundation

// String 확장

//첫번째 문자 얻기
extension String{
    func getFirstCahr() -> Character? {
    
        guard characters.count > 0 else {
            return nil
        }
        
        return self[startIndex]
    }
    
    //서브스트링 반환
    subscript (r: CountableClosedRange<Int>) -> String{
        //연산프로퍼티
        get {
            let start = index(self.startIndex, offsetBy: r.lowerBound)
            let end = index(self.startIndex, offsetBy: r.upperBound)
            return substring(with: start..<end)
        }
    }
}


//

//: [Next](@next)
