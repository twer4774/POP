//: [Previous](@previous)

import Foundation

//컬렉션 안에 있는 아이템을 섞거나 인덱스 번호가 짝수인 아이템만 반환
extension Collection {
    func evenElements() -> [Iterator.Element]{
        
        var index = startIndex
        var result: [Iterator.Element] = []
        var i = 0
        repeat {
            if i % 2 == 0 {
                result.append(self[index])
            }
            index = self.index(after: index)
            i += 1
        } while (index != endIndex)
        return result
    }
    
    func shuffle() -> [Iterator.Element]{
        return sorted() { left, right in
            return arc4random() < arc4random()
        }
    }
}

var originArray = [1,2,3,4,5,6,7,8,9,10]

var newArray = originArray.evenElements()
var ranArray = originArray.shuffle()

//: [Next](@next)
