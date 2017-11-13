//
//  main.swift
//  LearnSwiftForCollections
//
//  Created by susuyan on 2017/11/13.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
    Swift语言里的数组和字典中存储的数据值类型必须明确
    “If you create an array, a set, or a dictionary, and assign it to a variable,
     the collection that is created will be mutable”
 */

// MARK: - 创建一个空数组
var someInts = [Int]()

someInts.append(3)
someInts = []
print(someInts.isEmpty)

// MARK: - 创建一个有默认值的数组
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)

// MARK: - 两个数组组合成一个数组
var anotherThreeDoubles = Array(repeating: 3.0, count: 3)

var sixDoubles = threeDoubles + anotherThreeDoubles

print(sixDoubles)

// MARK: - 字面量定义数组
var shoppingList: [String] = ["Egg", "Milk"]
print("The shopping list contains \(shoppingList.count) items")
shoppingList.append("Flour")
shoppingList += ["Baking Podwer"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

print(shoppingList)
print(shoppingList[3...6])

shoppingList.insert("Maple Syrup", at: 0)
shoppingList.remove(at: 0)
shoppingList.removeLast()

// MARK - 便利数组
for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

// MARK - 创建和初始化一个空Set
var letters = Set<Character>()
print("letters is of type Set<Character> With \(letters.count) items")

letters.insert("A")
letters = []

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
print("I have \(favoriteGenres.count) favorite music genres.")

if favoriteGenres.contains("Rock") {
    print("Rock")
}else {
    print("No Rock")
}
// MARK - 遍历Set
for genre in favoriteGenres.sorted(){
    print(genre)
}

// MARK: - 基本Set操作
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitsPrimeNumbers: Set = [2, 3, 5, 7]

print(oddDigits.union(evenDigits).sorted())
print(oddDigits.intersection(singleDigitsPrimeNumbers).sorted())
print(oddDigits.symmetricDifference(singleDigitsPrimeNumbers).sorted())

// MARK: - 声明一个空字典
var namesOfIntergers = [Int: String]()

// MARK: - 字面量创建字典
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin Airpot"]
print("The airports dictionary contains \(airports.count) items.")

airports["LHR"] = "London"
print(airports)

if let oldValue = airports.updateValue("Dublin Airpot", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}

if let airportName = airports["DUB"] {
    print(airportName)
}else {
    print("No DUB")
}
airports.removeValue(forKey: "DUB")
print(airports)

// MARK: - 遍历字典
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
for airportCode in airports.keys {
    print("Airport Code: \(airportCode)")
}
for airportName in airports.values {
    print("Airoprt Name: \(airportName)")
}

let airportCodes = [String](airports.keys)
let airportNames = [String](airports.values)































