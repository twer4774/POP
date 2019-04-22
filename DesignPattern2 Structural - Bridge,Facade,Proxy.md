# 구조 디자인 패턴

- 어떻게 타입을 더 큰 구조체로 결합할 수 있는가를 서술
- 7가지 구조디자인 패턴
  - 어댑터(Adapter): 공존할 수 없는 인터페이스를 가진 타입을 함께 작동하게 해줌
  - 브리지(Bridge): 구현체로부터 타입의 추상적인 요소를 분리하는 데 사용
  - 컴포지트(Composite): 객체 그룹을 하나의 객채로 다룰 수 있게 함
  - 데코레이터(Decorator): 객체에 이미 존재하는 메소드에 행위를 추가하거나 해우이를 오버라드 함
  - 퍼사드(Facade): 더 크고 복잡한 코드를 위한 단순화된 인터페이스 제공
  - 플라이웨이트(Flyweight): 생성해야 하는 리소스를 줄이고 많은 유사한 객체를 사용하게 함
  - 프록시(Proxy): 다른 클래스나 여러 클래스를 위해 인터페이스처럼 행동하는 타입

### 브리지 패턴

- 구현체와 추상화가 독립적으로 달라질 수 있도록 구현체에서 추상화를 분리

- 두 계층을 가진 추상화와 유사

- 새로운 요구사항과 기능이 들어오면 기능 간에 상호작용하는 방식을 변경해야 한다.

  -> 브리지 패턴은 상호작용하는 기능을 갖고 기능 간에 공유하는 능력으로 부터 각 기능에 특화된 능력을 분리함으로써 이러한 문제를 해결함

```swift
//브릿지 패턴을 사용하지 않는 경우
protocol Message {
    var messageString: String { get set }
    init(messageString: String)
    func prepareMessage() //암호화하거나 포맷을 추가, 그 밖에 메시지를 보내기 전에 메시지에 하고자하는 일에 사용됨
}

//구체적인 채널을 통해 메시지를 보내는데 사용되는 타입을 위한 요구사항 정의
protocol Sender {
    func sendMessage(message: Message)
}

//Message 프로토콜을 따르는 두개의 클래스 정의
class PlainTextMessage: Message{
    var messageString: String
    //required : 상속받은 클래스에서 반드시 초기화가 필요한경우 키워드를 붙임
    required init(messageString: String) {
        self.messageString = messageString
    }
    func prepareMessage() {
        //아무것도 실행하지 않음
    }
    
}

class DESEncrtyptedMessage: Message {
    var messageString: String
    required init(messageString: String){
        self.messageString = messageString
    }
    
    func prepareMessage() {
        //암호화한 메시지를 생성한다.
        self.messageString = "DES: " + self.messageString
    }
}


//Sender 프로토콜을 따르는 두개의 타입
class EmaildSender: Sender {
    func sendMessage(message: Message) {
        print("Sending through E-Mail:")
        print("\(message.messageString)")
    }
}

class SMSSender: Sender {
    func sendMessage(message: Message) {
        print("Sending through SMS:")
        print("\(message.messageString)")
    }
}

var myMessage = PlainTextMessage(messageString: "Plain Text Message")
myMessage.prepareMessage()
var sender = SMSSender()
sender.sendMessage(message: myMessage)

//결과
Sending through SMS:
DES: Plain Text Message

// ----------------------------------------------------------------------------------

/* 만약 메시지를 보내게 되는 채널의 요구사항을 충족시킨다는 것을 확인하기 위해 메시지를 보내기 전에 이를 검증하는 새로운 기능을 추가해 달라는 요구사항이 있을 경우. Sender 프로토콜을 변경해야함*/

//브리지 패턴 이용

protocol Message {
    var messageString: String { get set }
    init(messageString: String)
    func prepareMessage() //암호화하거나 포맷을 추가, 그 밖에 메시지를 보내기 전에 메시지에 하고자하는 일에 사용됨
}

//구체적인 채널을 통해 메시지를 보내는데 사용되는 타입을 위한 요구사항 정의
//변경된 부분 --------------------------------------------
protocol Sender {
    var message: Message? { get set }
    func sendMessage()
    func verifyMessage()
}

//Message 프로토콜을 따르는 두개의 클래스 정의
class PlainTextMessage: Message{
    var messageString: String
    //required : 상속받은 클래스에서 반드시 초기화가 필요한경우 키워드를 붙임
    required init(messageString: String) {
        self.messageString = messageString
    }
    func prepareMessage() {
        //아무것도 실행하지 않음
    }
    
}

class DESEncrtyptedMessage: Message {
    var messageString: String
    required init(messageString: String){
        self.messageString = messageString
    }
    
    func prepareMessage() {
        //암호화한 메시지를 생성한다.
        self.messageString = "DES: " + self.messageString
    }
}


//Sender 프로토콜을 따르는 두개의 타입
//변경된 부분 --------------------------------------------
class EmaildSender: Sender {
    var message: Message?
    func sendMessage() {
        print("Sending through E-Mail:")
        print("\(message!.messageString)")
    }
    func verifyMessage() {
        print("Verifying E-Mail message")
    }
}

//변경된 부분 --------------------------------------------
class SMSSender: Sender {
    var message: Message?
    func sendMessage() {
        print("Sending through SMS:")
        print("\(message!.messageString)")
    }
    func verifyMessage() {
        print("Verifying SMS message")
    }
}

var myMessage = PlainTextMessage(messageString: "Plain Text Message")
myMessage.prepareMessage()
var sender = SMSSender()
sender.message = myMessage
sender.verifyMessage()
sender.sendMessage()


//브리지 패턴 이용 - 메시지와 발송자 계층이 어떻게 상호작용하는지에 대한 로직을 구조체 내부로 캡슐화함
struct MessagingBride {
    static func sendMessage(message: Message, sender: Sender){
        var sender = sender
        message.prepareMessage()
        sender.message = message
        sender.verifyMessage()
        sender.sendMessage()
    }
}

//결과
Verifying SMS message
Sending through SMS:
Plain Text Message
```



### 퍼사드 패턴

- 크고 복잡한 코드에 간소화된 인터페이스 제공
- 복잡한 것들을 숨김으로써 라이브러리를 사용하기 더 쉽고 이해하기 더 쉽게 만들어 준다.
- 여러 API를 하나의 더 쉬운 API로 결합하게 해준다.
- 함께 작동하게 설계된 수많은 독립적인 API를 가진 복잡한 시스템을 갖고 있는 경우에 사용 - 작업을 수행하기 위해 서로 긴밀히 작동하는 여러 API가 있는 경우에는 퍼사드 패턴을 고려해야 한다.
- 핵심개념 : API의 복잡성을 간단한 인터페이스 뒤로 숨기는 것
- 장점 : 외부 코드와 API간 상호작용을 단순화시켜 줌. 느슨한 결합을 통해 모든 코드를 리팩토링하지 않으면서 API를 변경할 수 있게 해줌
- 사용하는 경우 : 여러개의 API를 이용하여 결과 값을 얻어내야 할 경우 이용

```swift

//호텔 예약, 항공기, 렌터카 검색
struct Hotel {
    //호텔 객실에 대한 정보
}

struct HotelBooking{
    static func getHotelNameForDates(to: NSDate, from: NSDate) -> [Hotel]? {
        let hotels = [Hotel]()
        //호텔을 가져오는 로직
        return hotels
    }
    
    static func bookHotel(hotel: Hotel){
        //호텔 객실을 예약하는 로직
    }
}

//항공기 API
struct Flight {
     //항공기에 대한 정보
}

struct FlightBooking {
    static func getFlightNameForDates(to: NSDate, from: NSDate) -> [Flight]?{
        let flights = [Flight]()
        //항공기를 가져오는 로직
        return flights
    }
    
    static func bookFlight(flight: Flight){
        //항공기를 예약하는 로직
    }
}

//렌트카 API
struct RentalCar {
    //렌터카에 대한 정보
}

struct RentalCarBooking {
    static func getRentalCarNameForDates(to: NSDate, from: NSDate) -> [RentalCar]?{
        let cars = [RentalCar]()
        //렌트카를 가져오는 로직
        return cars
    }
    
    static func bookRentalCar(rentalCar: RentalCar){
        //렌트카를 예약하는 로직
    }
}

//파사드 패턴을 이용해 각각의 API의 구현 상태를 숨긴다. 나중에 API 동작방식을 변경하는 경우에는 코드 전체를 리팩토링 하지 않고 파사드 타입만 변경하여 유지 보수를 쉽게 한다.
struct TravelFacade {
    
    var hotels: [Hotel]?
    var flights: [Flight]?
    var cars: [RentalCar]?
    
    init(to: NSDate, from: NSDate){
        hotels = HotelBooking.getHotelNameForDates(to: to, from: from)
        flights = FlightBooking.getFlightNameForDates(to: to, from: from)
        cars = RentalCarBooking.getRentalCarNameForDates(to: to, from: from)
    }
    
    func bookTrip(hotel: Hotel, flight: Flight, rentalCar: RentalCar){
        HotelBooking.bookHotel(hotel: hotel)
        FlightBooking.bookFlight(flight: flight)
        RentalCarBooking.bookRentalCar(rentalCar: rentalCar)
    }
}

```



### 프록시 디자인 패턴

- 한가지 타입이 다른 타입 또는 API를 위한 인터페이스로 동작할 수 있음
- 객체에 기능을 추가하거나 API의 구현부를 숨기거나 객체의 접근을 제한시킬 수 있다.
- 이용하는 두가지 경우의 예
  - API와 코드사이에 추상레이어를 생성해야만 하는경우
    - 코드와 리모트 서비스 사이에 추상레이어를 추가하여 사용. 코드 전반에 걸쳐 리팩토링하지 않고도 리모트 API를 변경할 수 있게 해줌
    - API를 변경해야 하는 데 관련 코드를 가지고 있지 않거나 애플리케이션 내의 어딘가에서 이미 해당 API에 대한 의존성이 있는 경우

```swift

//iTunes API를 위해 프록시처럼 동작할 타입을 만드는 일 부터 시작해야 한다.
public typealias DataFromURLCompletionClosure = (Data?) -> Void

//프록시 만들기
public struct ITunesProxy{
    public func sendGetRequest(searchTerm: String, _ handler: @escaping DataFromURLCompletionClosure){
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        var url = URLComponents()
        url.scheme = "https"
        url.host = "itunes.apple.com"
        url.path = "/search"
        
        url.queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
        ]
        
        if let queryUrl = url.url{
            var request = URLRequest(url:queryUrl)
            request.httpMethod = "GET"
            let urlSession = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: nil)
            let sessionTask = urlSession.dataTask(with: request) {
                (data, response, error) in
                handler(data)
            }
            sessionTask.resume()
        }
    }
}

//프록시 이용
let proxy = ITunesProxy()
proxy.sendGetRequest(searchTerm: "jimmy+buffett", {
    if let data = $0, let sString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
        print(sString)
    } else {
        print("Data is nil")
    }
})

```

