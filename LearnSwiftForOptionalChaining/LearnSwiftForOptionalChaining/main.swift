//
//  main.swift
//  LearnSwiftForOptionalChaining
//
//  Created by susuyan on 2017/11/13.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 可选链是一种可以请求和调用属性、方法及下标脚本的过程
 它的可选性体现于请求或调用的目标当前可能为空（nil）
 如果可选的目标有值，那么调用就会成功，相反如果选择的目标为空（nil），则这种调用将返回空（nil）
 多次请求或调用可以被链接在一起形成一个链，如果任何一个节点为空（nil）将导致整个链失效
 */

/*
 Swift的可选链和Objective-C中的消息为空有些相像，但是swift可以使用在任意类型中，并且失败与否可以被检测到
 */

class Person1 {
    
    var residence: Residence1?
}

class Residence1 {
    var numberOfRooms = 1
    
}

let john = Person1()

// 如果自己定义一个 Resident 实例给 john.residence,这样它就不再为空了
//john.residence = Residence1()

//将导致运行时错误
//let roomCount = john.residence!.numberOfRooms
//print(roomCount)

if let roomCount = john.residence?.numberOfRooms{
    print("John's residence has \(roomCount) room")
}else {
    print("Unable to retrieve the number of rooms.")
}

// MARK: - 为可选链定义模型类
/*
 你可以使用可选链来调用多层调用属性，方法，和下标脚本
 这让你可以利用它们之间的复杂模型来获取更底层的属性，并检查是否可以成功获取此类底层属性
 */
class Person {
    var residence:Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        return rooms[i]
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
    
    
    
}
class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if (buildingName != nil) {
            return buildingName
        }else if (buildingNumber != nil) {
            return buildingNumber
        }else {
            return nil
        }
    }
}

// MARK: 通过可选链调用属性
/*
你可以利用可选链的可选值获取属性，并且检查属性是否获取成功
然而，你不能使用可选链为属性赋值
*/
let jack = Person()
if let roomCount = john.residence?.numberOfRooms{
    print("John's residence has \(roomCount) room(s).")
}else {
    print("Unable to retrieve the number of rooms")
}

// MARK: - 通过可选链调用方法
/*
 你可以使用可选链的来调用可选值的方法并检查方法调用是否成功
 即使这个方法没有返回值，你依然可以使用可选链来达成这一目的
 
 注：没有返回值类型的函数和方法有一个隐式的返回值类型 Void
 */

if ((jack.residence?.printNumberOfRooms()) != nil) {
    print("it was possible to print the number of rooms")
}else {
    print("it was not possible to print the number of rooms")
}
// MARK: -  使用可选链调用下标脚本
/*
 你可以使用可选链来尝试从下标脚本获取值并检查下标脚本的调用是否成功
 然而，你不能通过可选链来设置下标脚本。
 问号放在下标脚本括号的前面
 */
if let firstRoomName = jack.residence?[0].name {
    print("The first room name is \(firstRoomName)")
}else {
    print("Unable to retrieve the first room name")
}

let jackHouse = Residence()
jackHouse.rooms.append(Room(name: "Living Room"))
jackHouse.rooms.append(Room(name: "Kitchen"))
jack.residence = jackHouse

if let firstRoomName  = jack.residence?[0].name {
    print("The first room name is \(firstRoomName).")
}else {
    print("Uable to retrieve the first room name.")
}

// MARK: -  连接多层链接
/*
 你可以将多层可选链连接在一起，可以掘取模型内更下层的属性方法和下标脚本
 然而，多层可选链不能再添加比已经返回的可选值更多的层
 */
if let jackStreet = jack.residence?.address?.street {
    print("John's street name is \(jackStreet)")
}else {
    print("Unable to retrieve the address")
}

let jackAddress = Address()
jackAddress.buildingNumber = "The Larches"
jackAddress.street = "Laurel Street"
jack.residence!.address = jackAddress

if let jackStreet = jack.residence?.address?.street {
    print("Jack's street name is \(jackStreet)")
}else {
    print("Unable to retrieve the address")
}

// MARK: -  链接可选返回值的方法
/*
 通过可选链调用一个返回可选类型值得方法并按需链接该方法的返回值
 */
if let buildingIdentifier = jack.residence?.address?.buildingIdentifier(){
    print("Jack's building identifier is \(buildingIdentifier)")
}

if let upper = jack.residence?.address?.buildingIdentifier()?.uppercased() {
    print("Jack's uppercase building identifier is \(upper)")
}


// MARK: - Tips
/*
  使用 Optional Chaining 可以让我们摆脱很多不必要的判断和取值，但是在使用的时候需要小心陷阱
 */

class Toy {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child {
    var pet: Pet?
}

var xiaoming = Child()
if let toyName = xiaoming.pet?.toy?.name {
    print(toyName)
}

extension Toy {
    func play() {
        
    }
}

xiaoming.pet?.toy?.play()

let playClosure = {(child: Child) -> ()? in child.pet?.toy?.play()}

if let _:() = playClosure(xiaoming) {
    print("好开心")
}else {
    print("没有玩具可以玩")

}
































