//: [Previous](@previous)

import Foundation

//샘플코드를 위한 요구사항
/*
 - 이동수단은 해상, 지상, 공중 세 개의 범주를 갖게된다.
 - 이동수단은 여러 번주의 멤버가 될 수 있다.
 - 이동수단은 자신이 속해 있는 번주와 일치하는 타일에 있으면 이동 또는 공격할 수 있다.
 - 이동수단은 자신이 속해 있는 범주와 일치하는 타일에 있지 않으면 이동 또는 공격할 수 없다.
 - 이동수단의 체력이 0이 되면 이동수단은 움직이지 못하는 상ㅌ로 간주할 것이다.
 - 수회가 가능한 단일 배열에 활동 가능한 모든 이동수단을 갖고 있어야 한다.
*/

///프로토콜지향 프로그래밍 언어로서의 스위프트
/*
 프로토콜지향 프로그래밍을 객체지향과 다르게 만들어주는 기술 3가지
 1. 프로토콜 상속 : 다른 프로토콜을 상속받을 수 있다. OOP와 다른 점은 슈퍼클래스로부터 상속받는 대신, 프로토콜로부터 요구사항을 상속 받는다.
 프로토콜 상속이 클래스 상속보다 좋은 이유는 여러 프로토콜로부터 요구사항을 상속받을 수 있기 때문에 슈퍼클래스가 비대해지는 것을 방지할 수 있다.
 
 2. 프로토콜 컴포지션 : 하나이상의 프로토콜을 따를 수 있게 해준다.
 3. 프로토콜 확장 : 해당 프로토콜을 따르는 타입에 메소드와 프로퍼티 구현체를 제공하여 프로토콜을 확장할 수 있는 기능을 제공한다.
 */


protocol Vehicle {
    //이동수단의 남은 체력을 추적할 프로퍼티 정의
    var hitPoints: Int { get set }
}

//프로토콜 확장
extension Vehicle {
    mutating func takeHit(amount: Int){
        hitPoints -= amount
    }
    
    func hitPointsRemaining() -> Int{
        return hitPoints
    }
    
    func isAlive() -> Bool{
        return hitPoints > 0 ? true : false
    }
}

//LandVehicle, SeaVehicle, AirVehicle 프로토콜 정의
protocol LandVehicle: Vehicle {
    var landAttack: Bool { get }
    var landMovement: Bool { get }
    var landAttackRange: Int { get }
    
    func doLandAttack()
    func doLandMovement()
}

protocol SeaVehicle: Vehicle {
    var seaAttack: Bool { get }
    var seaMovement: Bool { get }
    var seaAttackRange: Int { get }
    
    func doSeaAttack()
    func doSeaMovement()
}

protocol AirVehicle: Vehicle {
    var airAttack: Bool { get }
    var airMovement: Bool { get }
    var airAttackRange: Int { get }
    
    func doAirAttack()
    func doAirMovement()
}

//Tank 타입 정의
struct Tank: LandVehicle {
    var hitPoints = 68
    let landAttackRange = 5
    let landAttack = true
    let landMovement = true
    
    func doLandAttack() { print("Tank Attack") }
    func doLandMovement() { print("Tank Move") }
}

//Amphibious 타입 정의
struct Amphibious: LandVehicle, SeaVehicle{
    var hitPoints = 25
    let landAttackRange = 1
    let seaAttackRange = 1
    
    let landAttack = true
    let landMovement = true
    
    let seaAttack = true
    let seaMovement = true
    
    let airAttack = true
    let airmovement = true
    
    func doLandAttack() {
        print("Amphibious Land Attack")
    }
    
    func doLandMovement() {
        print("Amphibious Land Move")
    }
    
    func doSeaAttack() {
        print("Amphibious Sea Attack")
    }
    
    func doSeaMovement() {
        print("Amphibious Sea Move")
    }
}

//Transformer 타입 정의
struct Transformer: LandVehicle, SeaVehicle, AirVehicle {
    var hitPoints = 75
    let landAttackRange = 7
    let seaAttackRange = 5
    let airAttackRange = 6
    
    let landAttack = true
    let landMovement = true
    
    let seaAttack = true
    let seaMovement = true
    
    let airAttack = true
    let airMovement = true
    
    func doLandAttack() {
        print("Transformer Land Attack")
    }
    func doLandMovement() {
        print("Transformer Land Move")
    }
    
    func doSeaAttack() {
        print("Transformer Sea Attack")
    }
    func doSeaMovement() {
        print("Transformer Sea Move")
    }
    
    func doAirAttack() {
        print("Transformer Air Attack")
    }
    func doAirMovement(){
        print("Transformer Air Move")
    }
}

//배열을 생성한 다음 이동 수단 타입 인스턴스 일부를 배열에 추가하여 동작
var vehicles = [Vehicle]()

var vh1 = Amphibious()
var vh2 = Amphibious()
var vh3 = Tank()
var vh4 = Transformer()

vehicles.append(vh1)
vehicles.append(vh2)
vehicles.append(vh3)
vehicles.append(vh4)


for (index, vehicle) in vehicles.enumerated() {
    if let Vehicle = vehicle as? AirVehicle {
        print("Vehicle at \(index) is Air")
    }
    
    if let Vehicle = vehicle as? LandVehicle{
        print("Vehicle at \(index) is Land")
    }
    
    if let Vehicle = vehicle as? SeaVehicle{
        print("Vehicle at \(index) is Sea")
    }
}

//모든 이동수단 타입이 아닌 이동수단의 어느 한 타입만을 얻고자 할 경우 where 절 사용
for (index, vehicle) in vehicles.enumerated() where vehicle is LandVehicle {
    let vh = vehicle as! LandVehicle
    if vh.landAttack {
        vh.doLandAttack()
    }
    
    if vh.landMovement{
        vh.doLandMovement
    }
}
//: [Next](@next)
