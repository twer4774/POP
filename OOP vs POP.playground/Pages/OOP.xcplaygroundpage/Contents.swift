import UIKit

//이동 수단 타입
enum TerrianType {
    case land
    case sea
    case air
}

//Vehicle 슈퍼클래스와 이를 포함하는 프로퍼티 정의
class Vehicle {
    //이동 수단 타입, 공격 타입, 이동 타입 프로퍼티 정의
    fileprivate var vehicleTypes = [TerrianType]()
    fileprivate var vehicleAttackTypes = [TerrianType]()
    fileprivate var vehicleMovementTypes = [TerrianType]()
    
    fileprivate var landAttackRange = -1
    fileprivate var seaAttackRange = -1
    fileprivate var airAttackRange = -1
    fileprivate var hitPoints = 0
    
    //프로퍼티의 값을 검색할 게터 메소드
    func isVehicleType(type: TerrianType) -> Bool{
        return vehicleTypes.contains(type)
    }
    //이동 수단이 어떤 지형타입에서 이동 및 공격을 할 수 있는지 확인하는 메소드
    func canVehicleAttack(type: TerrianType) -> Bool{
        return vehicleAttackTypes.contains(type)
    }
    func canVehicleMove(type : TerrianType) -> Bool{
        return vehicleMovementTypes.contains(type)
    }
    
    func doLandAttack() {}
    func doLandMovement() {}
    
    func doSeaAttack() {}
    func doSeaMovement() {}
    
    func doAirAttack() {}
    func doAirMovement() {}
    
    func takeHit(amount: Int) { hitPoints -= amount }
    func hitPointRemaining() -> Int{ return hitPoints }
    func isAlive() -> Bool { return hitPoints > 0 ? true : false}
    
}


//Tank 클래스
class Tank: Vehicle {
    override init() {
        super.init()
        vehicleTypes = [.land]
        vehicleAttackTypes = [.land]
        vehicleMovementTypes = [.land]
        landAttackRange = 5
        hitPoints = 68
    }
    
    override func doLandAttack() {
        print("Tank Attack")
    }
    
    override func doLandMovement() {
        print("Tank Move")
    }
}

//Amphibious(수륙양용) 클래스
class Amphibious: Vehicle {
    override init() {
        super.init()
        vehicleTypes = [.land, .sea]
        vehicleAttackTypes = [.land, .sea]
        vehicleMovementTypes = [.land, .sea]
        
        landAttackRange = 1
        seaAttackRange = 1
        
        hitPoints = 25
    }
    //지상 이동 및 공격
    override func doLandAttack() {
        print("Amphibious Land Attack")
    }
    override func doLandMovement() {
        print("Amphibious Land Move")
    }
    
    //해상 이동 및 공격
    override func doSeaAttack() {
        print("Amphibious Sea Attack")
    }
    override func doSeaMovement() {
        print("Amphibious Sea Move")
    }
}


//Transformer(세 지형 타입 모두 이동 및 공격 가능) 클래스
class Transformer: Vehicle{
    override init(){
        super.init()
        vehicleTypes = [.land, .sea, .air]
        vehicleAttackTypes = [.land, .sea, .air]
        vehicleMovementTypes = [.land, .sea, .air]
        
        landAttackRange = 7
        seaAttackRange = 10
        airAttackRange = 12
        
        hitPoints = 75
    }
    
    override func doLandAttack(){
        print("Transformer Land Attack")
    }
    override func doLandMovement(){
        print("Transforemr Land Move")
    }
    
    override func doSeaAttack(){
        print("Transformer Sea Attack")
    }
    override func doSeaMovement(){
        print("Transforemr Sea Move")
    }
    
    override func doAirAttack(){
        print("Transformer Land Attack")
    }
    override func doAirMovement(){
        print("Transforemr Air Move")
    }
    
}

//다형성을 이용하여 여러 타입과상호 작용
var vehicles = [Vehicle]()
var vh1 = Amphibious()
var vh2 = Amphibious()
var vh3 = Tank()
var vh4 = Transformer()
vehicles.append(vh1)
vehicles.append(vh2)
vehicles.append(vh3)
vehicles.append(vh4)

//Vehicle 타입에서 제공하는 인터페이스로 배열을 순회해 각각의 인스턴스와 상호작용할 수 있음
for (index, vehicle) in vehicles.enumerated() {
    if vehicle.isVehicleType(type: .air) {
        print("Vehicle at \(index) is Air")
        if vehicle.canVehicleAttack(type: .air){
            vehicle.doAirAttack()
        }
        
        if vehicle.canVehicleMove(type: .air){
            vehicle.doAirMovement()
        }
    }
    
    if vehicle.isVehicleType(type: .land) {
        print("Vehicle at \(index) is Land")
        if vehicle.canVehicleAttack(type: .land){
            vehicle.doLandAttack()
        }
        
        if vehicle.canVehicleMove(type: .land){
            vehicle.doLandMovement()
        }
    }
    
    if vehicle.isVehicleType(type: .sea){
        print("Vehicle at \(index) is Sea")
        if vehicle.canVehicleAttack(type: .sea){
            vehicle.doSeaAttack()
        }
        if vehicle.canVehicleMove(type: .sea){
            vehicle.doSeaMovement()
        }
    }
}
