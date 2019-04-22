//: [Previous](@previous)

import Foundation

enum Device {
    case IPod
    case IPhone
    case IPad
}

//Swift 열거형의 특징
//원시 값으로 불리는 값을 할당 할 수 있음 - 타입정의 필요
enum Device2: String {
    case IPod = "iPod"
    case IPhone = "iPhone"
    case IPad = "iPad"
}

Device2.IPod.rawValue

//커스텀 정보 저장
enum Device3 {
    case IPod(model: Int, year: Int, memory: Int)
    case IPhone(model: String, memory: Int)
    case IPad(model: String, memory: Int)
}

var myPhone = Device3.IPhone(model: "6", memory: 64)
var myTablet = Device3.IPad(model: "Pro", memory: 128)

switch myPhone{
case .IPod(let model, let year, let memory):
    print("iPod: \(model) \(memory)")
case .IPhone(let model, let memory):
    print("iPhone: \(model) \(memory)")
case .IPad(let model, let memory):
    print("iPad: \(model) \(memory)")
    
}

//열거형에서 메소드와 연산 프로퍼티 사용
enum Reindeer: String {
    case Dasher, Dancer, Prancer, Vixen, Comet, Cupid, Donner, Blitzen, Rudolph
    
    static var allCases: [Reindeer]{
        return [Dasher, Dancer, Prancer, Vixen, Comet, Cupid, Donner, Blitzen, Rudolph]
    }
    
    static func randomCase() -> Reindeer{
        let randomValue = Int(arc4random_uniform(UInt32(allCases.count))))
        return allCases[randomValue]
    }
}

//: [Next](@next)
