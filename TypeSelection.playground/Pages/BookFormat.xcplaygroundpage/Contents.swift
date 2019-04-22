//: [Previous](@previous)

import Foundation


//열거형은 클래스나 구조체를 대체할 수는 없음(유한한 셋으로 구성)
enum BookFormat {
    case PapaerBack(pageCount: Int, price: Double)
    case HardCover(pageCount: Int, price: Double)
    case PDF(pageCount: Int, price: Double)
    case EPub(pageCount: Int, price: Double)
    case Kindle(pageCount: Int, price: Double)
    
    //검색을 용이하게 하기 위해 연산프로퍼티 추가
    var pageCount: Int{
        switch self{
        case .PapaerBack(let pageCount, _):
            return pageCount
        case .HardCover(let pageCount, _):
            return pageCount
        case .PDF(let pageCount, _):
            return pageCount
        case .EPub(let pageCount, _):
            return pageCount
        case .Kindle(let pageCount, _):
            return pageCount
        }
    }
    
    var price: Double{
        switch self {
        case .PapaerBack(_, let price):
            return price
        case .HardCover(_, let price):
            return price
        case .PDF(_, let price):
            return price
        case .EPub(_, let price):
            return price
        case .Kindle(_, let price):
            return price
        }
    }
    
    //열거형 안에 메소드 추가 가능
    func purchaseTogether(otherFormat: BookFormat) -> Double{
        return (self.price + otherFormat.price) * 0.80
    }
}

//연산프로퍼티로 열거형의 연관 값을 손쉽게 가져옴
var paperBack = BookFormat.PapaerBack(pageCount: 220, price: 39.99)
print("\(paperBack.pageCount) - \(paperBack.price)")

var pdf = BookFormat.PDF(pageCount: 180, price: 14.99)
var total = paperBack.purchaseTogether(otherFormat: pdf)

//: [Next](@next)
