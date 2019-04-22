//: [Previous](@previous)

import Foundation

//클래스 - 기본생성자 미제공
class MyClass{
    var oneProperty: String
    
    init(oneProperty: String){
        self.oneProperty = oneProperty
    }
    
    func oneFunction(){
        
    }
}


//구조체 - 기본생성자 제공
//구조체에 정의된 메소드 중 일부는 mutating 키워드 이용
//구조체는 값 타입이기 때문에 기본적으로 인스턴스 메소드 내부에서는 구조체 프로퍼티 값을 변경할 수 없음 => 구조체의 프로퍼티 값 변경
struct MyStruct {
    var oneProperty: String
    
    func oneFunction(){
        
    }
}

// 접근제어
/*
 Open: 해당 아이템이 정의된 모듈 내에 있는 모든 아이템에서 서브클래싱이나 오버라이딩을 할 수 있음. 주로 프레임워크의 공개 API를 노출시키기 위해 사용 - 외부확장 가능
 
 Public: 해당 아이템이 정의된 모듈 내에 있는 모든 아이템에서 서브클래싱하거나 오버라이딩할 수 있음. 주로 프레임워크에서 프레임워크의 공개 API를 노출시키기 위해 사용 - 외부확장 불가
 
 Internal: 프레임워크의 다른 부분에서는 아이템을 사용할 수 있지만, 프레임워크 외부 코드에서는 아이템에 접근할 수 없음
 
 Fileprivate: 아이템이 정의되어 있는 소스파일과 동일한 코드 내부에서 프로퍼티와 메소드의 접근 허용
 
 Private: 소스 파일 내부에서만 프로퍼티와 메소드, 클래스 등을 사용하는 것을 허용
 */
//: [Next](@next)
