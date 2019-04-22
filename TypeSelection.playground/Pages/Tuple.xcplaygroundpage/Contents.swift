//: [Previous](@previous)

import Foundation

//쉼표로 구분하는 순서 있는 요소의 목록
let mathGrade1 = ("Jo", 100)
let (name, score) = mathGrade1
print("\(name) - \(score)")

//이름이 있는 튜플
let mathGrade2 = (name: "Jo", grade: 100)
print("\(mathGrade2.name) - \(mathGrade2.grade)")

//튜플을 사용해 함수에서 여러 값을 반환하는 방법
func calculateTip(billAmount: Double, tipPercent: Double) -> (tipAmount: Double, totalAmount: Double){
    let tip = billAmount * (tipPercent/100)
    let total = billAmount + tip
    return (tipAmount: tip, totalAmount: total)
}
var tip = calculateTip(billAmount:31.98, tipPercent: 20)
print("\(tip.tipAmount) - \(tip.totalAmount )")
//: [Next](@next)
