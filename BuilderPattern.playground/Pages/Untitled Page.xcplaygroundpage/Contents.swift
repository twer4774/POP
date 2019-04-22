import UIKit

//빌더패턴을 사용하지 않고 복잡한 구조체를 만드는 방법 -----------------------------------------
struct BurgerOld {
    var name: String
    var patties: Int
    var bacon: Bool
    var cheese: Bool
    var pickles: Bool
    var ketchup: Bool
    var mustard: Bool
    var lettuce: Bool
    var tomato: Bool
    init(name: String, patties: Int, bacon: Bool, cheese: Bool, pickles: Bool, ketchup: Bool, mustard: Bool, lettuce: Bool, tomato: Bool ){
        self.name = name
        self.patties = patties
        self.bacon = bacon
        self.cheese = cheese
        self.pickles = pickles
        self.ketchup = ketchup
        self.mustard = mustard
        self.lettuce = lettuce
        self.tomato = tomato
    }
}

//햄버거를 생성한다.
var hamBurger = BurgerOld(name: "Hamburger", patties: 1, bacon: false, cheese: false, pickles: false, ketchup: false, mustard: false, lettuce: false, tomato: false)

//치즈버거 생성
var cheeseBurger = BurgerOld(name: "Cheeseburger", patties: 1, bacon: false, cheese: true, pickles: true, ketchup: true, mustard: true, lettuce: false, tomato: false)
//빌더패턴을 사용하지 않고 복잡한 구조체를 만드는 방법 끝-----------------------------------------

/*
//빌더패턴을 사용하여 구조체를 만드는 방법 ----------------------------------------------------
//BurgerBuilder 프로토콜 정의
protocol BurgerBuilder {
    var name: String {get}
    var patties: Int {get}
    var bacon: Bool {get}
    var cheese: Bool {get}
    var pickles: Bool {get}
    var ketchup: Bool {get}
    var mustard: Bool {get}
    var lettuce: Bool {get}
    var tomato: Bool {get}
}

//햄버거 빌더 정의
struct HambergerBuilder: BurgerBuilder{
    let name = "Buerger"
    let patties = 1
    let bacon = false
    let cheese = false
    let pickles = true
    let ketchup = true
    let mustard = true
    let lettuce = false
    let tomato = false
}

//치즈버거 빌더 정의
struct CheeseBurgerBuilder: BurgerBuilder{
    let name = "CheeseBuerger"
    let patties = 1
    let bacon = false
    let cheese = true
    let pickles = true
    let ketchup = true
    let mustard = true
    let lettuce = false
    let tomato = false
}

//버거 구조체 정의
struct Burger {
    var name: String
    var patties: Int
    var bacon: Bool
    var cheese: Bool
    var pickles: Bool
    var ketchup: Bool
    var mustard: Bool
    var lettuce: Bool
    var tomato: Bool
    
    init(builder: BurgerBuilder){
        self.name = builder.name
        self.patties = builder.patties
        self.bacon = builder.bacon
        self.cheese = builder.cheese
        self.pickles = builder.pickles
        self.ketchup = builder.ketchup
        self.mustard = builder.mustard
        self.lettuce = builder.lettuce
        self.tomato = builder.tomato
    }
    
    func showBurger() {
        print("Name : \(name)")
        print("Patties: \(patties)")
        print("Bacon: \(bacon)")
        print("Cheese: \(cheese)")
        print("Pickles: \(pickles)")
        print("Ketchup: \(ketchup)")
        print("Mustard: \(mustard)")
        print("Lettuce: \(lettuce)")
        print("Tomato: \(tomato)")
    }

}

//햄버거를 생성한다.
var myBurger = Burger(builder: HambergerBuilder())
myBurger.showBurger()

//토마토가 들어간 치즈버거를 생성한다.
var myCheesBurgerBuilder = CheeseBurgerBuilder()
var myCheesBurger = Burger(builder: myCheesBurgerBuilder)

//토마토를 뺀다.
myCheesBurger.tomato = false
myCheesBurger.showBurger()
*/

//빌더패턴을 사용하여 구조체를 만드는 방법 끝----------------------------------------------------

//단일 빌더 타입을 갖는 빌더패턴 ------------------------------------------------------------
//기존의 코드와 통합하기 쉽기 때문에 오래된 코드를 업데이트 할 경우 많이 사용함
//단일 BurgerBuilder 구조체 정의 - 기본값 설정
struct BurgerBuilder {
    var name = "Buerger"
    var patties = 1
    var bacon = false
    var cheese = false
    var pickles = true
    var ketchup = true
    var mustard = true
    var lettuce = false
    var tomato = false
    
    mutating func setPatties(choice: Int) {self.patties = choice}
    mutating func setBacon(choice: Bool) {self.bacon = choice}
    mutating func setCheese(choice: Bool) {self.cheese = choice}
    mutating func setPickles(choice: Bool) {self.pickles = choice}
    mutating func setKetchup(choice: Bool) {self.ketchup = choice}
    mutating func setMustard(choice: Bool) {self.mustard = choice}
    mutating func setLettuce(choice: Bool) {self.lettuce = choice}
    mutating func setTomato(choice: Bool) {self.tomato = choice}
    
    func buildBurgerOld(name: String) -> BurgerOld {
        return BurgerOld(name: name, patties: self.patties, bacon: self.bacon, cheese: self.cheese, pickles: self.pickles, ketchup: self.ketchup, mustard: self.mustard, lettuce: self.lettuce, tomato: self.tomato)
    }
}

var burgerBuilder = BurgerBuilder()
burgerBuilder.setCheese(choice: true)
burgerBuilder.setBacon(choice: true)
var joBurger = burgerBuilder.buildBurgerOld(name: "JoBurger")

//단일 빌더 타입을 갖는 빌더패턴 끝 ------------------------------------------------------------
