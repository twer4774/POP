import UIKit

class MySingleton{
    //정적상수 생성 - 정적상수는 클래스를 인스턴스화 하지 않아도 사용할 수 있다.
    static let sharedInstance = MySingleton()
    var number = 0
    private init() {}
}

var singleA = MySingleton.sharedInstance
var singleB = MySingleton.sharedInstance
var singleC = MySingleton.sharedInstance
singleB.number = 2
print(singleA.number)
print(singleB.number)
print(singleC.number)
singleC.number = 3
print(singleA.number)
print(singleB.number)
print(singleC.number)
