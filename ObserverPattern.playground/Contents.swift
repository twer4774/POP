import UIKit

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

// -----------------------------------------------------------------
//옵저버 패턴 2
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
