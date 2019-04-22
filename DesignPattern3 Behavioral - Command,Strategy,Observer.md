# 행위 디자인 패턴

- 타입 간에 상호작용이 어떻게 이뤄지는지를 설명
- 어떠한 일을 발생시키기 위해 어떻게 서로 다른 타입의 인스턴스 간에 미시지를 보내는지 설명
- 9가지 행위 디자인 패턴
  - 책임 연쇄(Chain of responsibility): 다른 핸들러에 위임돼 있을지 모른는 다양한 요청을 처리
  - 커맨드(Command): 나중에 다른 컴포넌트에 의해 실행 될 수 있게 행동이나 매개변수를 캡슐화한 객체 생성
  - 이터레이터(Itrator): 근본적인 구조는 노출시키지 않으면서 객체의 요소에 연속적으로 접근할 수 있게 함
  - 미디에이터(Mediator): 서로 정보를 전달하는 타입 간의 결합도를 줄이는데 사용
  - 메멘토(Memento): 객체의 현재 상태를 캡처하고 나중에 복구할 수 있게 객체를 얼마간 저정하는 데 사용
  - 옵저버(Observer): 객체의 변경 상태를 알리게 해준다. 다른 객체는 변경사항에 대한 알림을 받기위해 이를 구독할 수 있다.
  - 스테이트(State) : 내부 상태가 변경될 경우 객체의 행동을 변경하기 위해 사용
  - 스트래티지(Strategy): 런타임에서 알고리즘 계열 중 하나를 선택하게 해준다.
  - 비지터(Visitor) : 객체 구조로 부터 알고리즘을 분리하기 위해 사용

### 커맨드 디자인 패턴

- 사용자아게 나중에 실행 할 수 있는 행동을 정의하도록 요구한다. 일반적으로 커맨드 패턴은 나중에 호출하거나 행동을 해야하는 모든 정보를 캡슐화 한다.
- 커맨드 실행과 호출자를 서로 분리해야만 하는 경우가 발생한다. 여러 해동 중 하나를 수행해야만 하는 타입이 있고, 사용해야 하는 행동을 선택하는 시점은 런타임 단계에서 이뤄져야 하는 경우가 이에 해당한다.

```swift
protocol MathCommand {
    func execute(num1: Double, num2: Double) -> Double
}

struct AdditionCommand: MathCommand {
    func execute(num1: Double, num2: Double) -> Double {
        return num1 + num2
    }
}

struct SubtractionCommand: MathCommand {
    func execute(num1: Double, num2: Double) -> Double {
        return num1 - num2
    }
}

struct MultiplicationCommand: MathCommand {
    func execute(num1: Double, num2: Double) -> Double {
        return num1 * num2
    }
}

struct DivisionCommand: MathCommand {
    func execute(num1: Double, num2: Double) -> Double {
         return num1 / num2
    }
}

//호출자 생성
struct Calculator{
    func performCalculation(num1: Double, num2: Double, command: MathCommand) -> Double {
        return command.execute(num1: num1, num2: num2)
    }
}

//사용
var calc = Calculator()
var startValue = calc.performCalculation(num1: 25, num2: 10, command: SubtractionCommand())
var answer = calc.performCalculation(num1: startValue, num2: 5, command: MultiplicationCommand())

```

-  커맨드 디자인 패턴의 장점
  - 실행하는 커맨드를 런타임에서 설정할 수 있음
  - 컨테이너 타입에 있는 내용이 아니라, 커맨드 타입 자신에 있는 커맨드 구현체의 상세 내용을 캡슐화 한다는 점



### 스트래티지 패턴

- 호출하는 타입으로부터 자세한 구현 사항을 분리하고 런타임에서 구현체를 교체시킬 수 있게 해준다는 점에서 커맨드 패턴과 매우 유사
- 알고리즘을 캡슐화하는 경향이 있다는 점에서 커맨드 패턴과 구분됨
- 알고리즘을 바꿈으로써 객체가 같은 기능을 다른 방법으로 수행하기를 기대 함

```swift
protocol CompressionStrategy {
    func compressFiles(filePaths: [String])
}

//두 종류의 구조체 생성
struct ZipCompressionStrategy: CompressionStrategy {
    func compressFiles(filePaths: [String]) {
        print("Using Zip Compression")
    }
}

struct RarCompressionStrategy: CompressionStrategy {
    func compressFiles(filePaths: [String]) {
        print("Using RAR Compression")
    }
}

//호출 할 타입 생성
struct CompressContent {
    var strategy: CompressionStrategy
    func compressFiles(filePaths: [String]) {
        self.strategy.compressFiles(filePaths: filePaths)
    }
}

var filePaths = ["file1.txt", "file2.txt"]
var zip = ZipCompressionStrategy()
var rar = RarCompressionStrategy()

var compress = CompressContent(strategy: zip)
compress.compressFiles(filePaths: filePaths)

compress.strategy = rar
compress.compressFiles(filePaths: filePaths)

```



### 옵저버 패턴

- 다른 타입에서 이벤트가 발생하는 경우, 이벤트 처리를 위해 구현
- 객체 사이의 의존성을 거의 갖지 않으면서 서로 협력할 수 있게 해준다.

```swift
//옵저버 패턴 1
let NCNAME = "Notification Name"

//알림을 전달하는 타입 생성
class PostType {
    let nc = NotificationCenter.default
    func post() {
        nc.post(name: Notification.Name(rawValue: NCNAME), object:  nil)
    }
}


//알림센터와 함께 셀렉터 등록
class ObserverType {
    let nc = NotificationCenter.default
    init() {
        nc.addObserver(self, selector: #selector(receiveNotification(notification:)), name: Notification.Name(rawValue: NCNAME), object: nil)
    }
    
    @objc func receiveNotification(notification: Notification) {
        print("Notification Received")
    }
}

var postType = PostType()
var observerType = ObserverType()
postType.post()


//결과
Notification Received


//옵저버패턴 2
protocol ZombieObserver {
    func turnLeft()
    func turnRight()
    func seeUs()
}

class MyObserver: ZombieObserver{
    func turnLeft() {
        print("left")
    }
    
    func turnRight() {
        print("right")
    }
    
    func seeUs() {
        print("see us")
    }
}

//Zombie타입 구현. 움직이거나 누군가를 발견할 경우 옵접버 알림을 보냄
struct Zombie {
    var observer: ZombieObserver
    
    func turnZombieLeft(){
        //왼쪽으로 도는 코드
        //옵저버에게 알린다.
        observer.turnLeft()
    }
    
    func turnZombieRight(){
        //오른쪽으로 도는 코드
        //옵저버에게 알린다.
        observer.turnRight()
    }
    
    func spotHuman(){
        //사람을 추적하는 코드
        //옵저버에게 알린다.
        observer.seeUs()
    }
}

var observer = MyObserver()
var zombie = Zombie(observer: observer)

zombie.turnZombieLeft()
zombie.spotHuman()

//결과
left
see us
```



- ### 