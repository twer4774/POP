//: [Previous](@previous)

import Foundation

//MARK: 로봇에 대한 프로토콜 정의 -----------------------------
//2차원 움직임은 5가지의 메소드 정의
protocol RobotMoveMent{
    func forward(speedPercent: Dobule)
    func reverse(speedPercent: Dobule)
    func left(speedPercent: Double)
    func right(speedPercent: Double)
    func stop()
}

//만약 하늘을 나는 로봇이 있다면?? -> 위아래로 움직이는 동작 추가(프로토콜 상속)
protocol RobotMoveMentThreeDimensions: RobotMoveMent{
    func up(speedPercent: Double)
    func down(speedPercent: Double)
}

//로봇 타입을 위한 요구사항 정의
protocol Robot{
    var name: String { get set }
    var robotMovement: RobotMoveMent { get set }
    var sensors: [Sensor] { get }
    
    init(name: Strinlg, robotMovement: RobotMoveMent)
    func addSensor(sensor: Sensor)
    func pollSensors()
}

//로봇 타입을 따르는 클래스 정의
class SixWheelRover: Robot{
    var name = "No Name"
    var robotMovement: robotMovement
    var sensors: [Sensor] = [Sensor]()
    
    required init (name: String, robotMovement: RobotMovement){
        self.name = name
        self.robotMovement = robotMovement
    }
    
    //센서 추가
    func addSensor(sensor: Sensor){
        sensors.append(sensor)
    }
    
    func pollSensors() {
        for sensor in sensors {
            sensor.pollSensor()
        }
    }
    
    //범위인식 센서 추가
    func addRangeSensor(sensor: RangeSensor, rangeCentimeter: Double){
        sensor.setRangeNotification(rangeCentimeter: rangeCentimeter, rangenotification: rangeNotification)
    }
    
    //무선 센서 추가
    func addWirelessSensor(sensor: WirelessSensor){
        addSensor(sensor: sensor)
        sensor.setMessageReceivedNotification(messageNotification: messageReceived)
    }
    
    //일정 범위에 들어오면 알림
    func rangeNotification() {
        print("Too Close")
    }
    
    //알림을 받는 함수
    func messageReceived(message: String){
        print("Message Received: " + message)
    }
}
//MARK: 로봇에 대한 프로토콜 정의 끝 ------------------------------

//MARK: 센서프로토콜 활용 (위의 로봇에 부착할 것임)----------------------
///센서 타입에서 상속받을 센서 프로토콜 정의
protocol Sensor{
    var sensorType: String { get }
    var snesorname: String { get set }
    
    init (sensorName: String)
    //정기적으로 센서의 값을 읽는데 사용
    func pollSensor()
}

/* 센서 프로토콜을 상속하는 다양한 센서들 */
//환경 센서
protocol EnvironmentSensor: Sensor{
    //센서에서 읽어낸 마지막 온도를 반환
    func currentTemperature() -> Double
    //센서에서 읽어낸 마지막 습도를 반환
    func currentHumidity() -> Double
}

//범위 센서
protocol RangeSensor: Sensor {
    //클로저를 매개변수로 받음. 어떠한 일이 발생했을 경우 로봇 코드에 즉시 알려주기위해 pollSensor()메소드 내에서 이용될 예정
    func setRangeNotification(rangeCentimeter: Dobule, rangeNotification: () -> Void)
    func currentRange() -> Double
}

//디스플레이 센서
protocol DisplaySensor: Sensor {
    func displayMessage(message: String)
}

//무선 센서
protocol WirelessSensor: Sensor {
    //메시지 알림 받기. 로봇이 물체의 특정거리에 들어오면 전송되는 메시지를 받는 부분. 클로저를 통해 즉각적으로 반응
    func setMessageReceivedNotification(messageNotification: (String) -> Void)
    func messageSend(message: String)
}

//MARK: 센서프로토콜 종료 --------------------------------

//: [Next](@next)
