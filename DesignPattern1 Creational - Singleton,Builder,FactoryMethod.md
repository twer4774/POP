# 디자인 패턴

- 공통의 소프트웨어 개발문제를 확인하고 다루기 위한 전략
- 유지하기 쉬운 일관된 코드를 얻고, 재사용이 가능하게 해준다.
- 디자인 패턴의 세가지 범주
  - 생성패턴(Creational patterns) : 객체의 생성을 지원
  - 구조패턴(Structural patterns): 타입과 객체 컴포지션과 관련
  - 행위패턴(Behavioral patterns): 타입간의 소통과 관련

## 생성 패턴

- 객체를 어떻게 생성하는지 다루는 디자인 패턴

- 기본개념

  - 어떤 구체적인 타입이 생성돼야 하는지에 대한 정보를 캡슐화 하는 것
  - 타입의 인스턴스가 어떻게 생성되는지를 숨기는 것

- 주요패턴 5가지

  - 추상 팩토리 패턴(Abstact factory pattern): 구체적인 타입을 명시하지 않으면서 관련된 객체를 생성하기 위한 인터페이스를 제공
  - 빌더 패턴(Builder pattern): 복잡한 객체의 생성과 표현을 서로 분리해 유사한 타입을 생성하기 위해 동일한 프로세스가 사용될 수 있게 함
  - 팩토리 메소드 패턴(Factory method pattern): 객체(또는 객체의 타입)를 어떻게 생성하는지에 대한 근본적인 로직을 노출하지 않으면서 객체를 생성함
  - 프로토타입 패턴(Prototype pattern): 이미 존재하는 객첼를 복사하는 방식으로 객체 생성
  - 싱글턴 패턴(Singleton pattern): 애플리케이션 주기 동안 하나의 클래스 인스턴스를 사용

  

  

### 싱글턴 패턴

- 내부나 외부 리소스의 집중적 관리가 필요한 경우나 접근할 수 있는 단일 정적 포인트가 필용한 경우 사용
- 애플리케이션이 동작하는 내내 필요한 상태를 갖지 않는 연관된 행동들을 통합하고 싶은 경우

```swift
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

2
2
2
3
3
3
```

- 애플리케이션 라이플 사이클 내내 클래스의 인스턴스가 오직 단 한개만 존재해야하는 구체적인 요구사항이 있는 경우에만 사용
- 주의사항: 싱글턴패턴은 참조타입에서 이용해야한다. 값타입인경우 인스턴스를 복사하는 개념으로, 호출 시 다중의 인스턴스가 필요한다.



### 빌더 디자인 패턴

- 복잡한 객체의 생성을 도우면서 어떻게 이러한 객체들을 생성하는지에 대한 프로세스를 강제함
- 복잡한 타입으로부터 생성 로직을 분리하며, 다른 타입을 추가한다.
- 타입의 서로 다른 결과물을 생성하는 데 동일한 생성 프로세스를 사용하게 해준다.
- 타입의 인스턴스가 설정 가능한 여러 값을 요구하는 문제를 해결하기 위해 설계됨
- 클래스의 인스턴스를 생성할 때 설정 옵션을 추가할 수도 있지만, 옵션이 올바르게 설정되지 않거나 모든 옵션에 대한 적절한 값을 알지 못하는 경우에는 문제가 발생 할 수 있다.
- 모든 설정 가능한 옵션을 설정하는 데 많은 양의 코드가 필요하다.
- builder 타입으로 알려진 중개자를 이용해 문제 해결
- 빌더 패턴을 구현하는 두가지 방법
  - 구체적인 방법 : 원래의 복잡한 객체를 설정하는 정보를 가진 여러 가지의 빌더 타입을 갖는 방식
  - 모든 설정 가능한 옵션을 기본 값으로 설정하는 단일 빌더 타입을 사용해 빌더 패턴을 구현하며, 필요하다면 옵션 값을 변경하는 방식

```swift
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
```

```swift
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

//빌더패턴을 사용하여 구조체를 만드는 방법 끝----------------------------------------------------

Name : Buerger
Patties: 1
Bacon: false
Cheese: false
Pickles: true
Ketchup: true
Mustard: true
Lettuce: false
Tomato: false

Name : CheeseBuerger
Patties: 1
Bacon: false
Cheese: true
Pickles: true
Ketchup: true
Mustard: true
Lettuce: false
Tomato: false

```

```swift
/* 위의 buildBurgerOld 필요 */
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

```



### 팩토리 메소드 패턴

- 생성할 정확한 타입을 명하지 않으면서 객체의 인스섵스를 새엉하는 메소드 사용
- 생성할 타입을 런타임이 선택하게 해준다
- 하나의 프로토콜을 따르는 여러 타입이 있고, 인스턴스화하기 위해 적절한 타입을 런타임에서 선택해야하는 문제를 해결하기 위해 설계됨

```swift
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

String validated: Optional(true)
String validated: Optional(true)
```

