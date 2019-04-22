import UIKit

protocol Message {
    var messageString: String { get set }
    init(messageString: String)
    func prepareMessage() //암호화하거나 포맷을 추가, 그 밖에 메시지를 보내기 전에 메시지에 하고자하는 일에 사용됨
}

//구체적인 채널을 통해 메시지를 보내는데 사용되는 타입을 위한 요구사항 정의
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

//브리지 패턴 이용
struct MessagingBride {
    static func sendMessage(message: Message, sender: Sender){
        var sender = sender
        message.prepareMessage()
        sender.message = message
        sender.verifyMessage()
        sender.sendMessage()
    }
}


