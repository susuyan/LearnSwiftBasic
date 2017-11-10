//
//  main.swift
//  LearnSwiftForProperties
//
//  Created by susuyan on 2017/11/10.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK: - Properties
/*
 存储属性存储常量或变量作为实例的一部分，计算属性计算（而不是存储）一个值。
 计算属性可以用于类、结构体、和枚举里，存储属性只能用于类和结构体
*/

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)

/*
 结构体属于值类型，当值类型的实例被声明为常量的时候，它的所有属性也就成了常量
 */
//rangeOfFourItems.firstValue = 6

// MARK: - 延迟属性
/*
 当属性的值依赖于在实例的构造过程结束前无法知道具体值的外部因素时，
 或者当属性的值需要复杂或大量计算时，可以只在需要的时候来计算它
 */

class DataImporter {
    var fileName = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter() //  使用 lazy 关键字，作为声明延迟存储属性
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

//importer 属性只有在第一次被访问的时候才被创建
print(manager.importer.fileName)

/*
  在 Objective-c 中，属性声明的时候，都对应生成一个成员变量，
  而在 Swift 中，简化了。
 一个类型中属性的全部信息---（包括命名、类型和内存管理特征）都在一个地方定义
*/

// MARK: - 计算属性
/*
 类、结构体和枚举可以定义计算属性，
 计算属性不直接存储之，而是提供一个 getter 来获取值，一个可选的 setter 来间接设置其他属性或变量的值
 */

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}

struct  Rect {
    var origin = Point()
    var size = Size()
   
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        set (newCenter){
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
/*
 center 就是一个计算属性，Rect 根据自定义 getter 和 setter 来获取和设置 Rect 的中心点
 */

var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x),\(square.origin.y))")

// MARK: -  便捷 setter 声明
/*
  如果计算属性的 setter 没有定义表示新值得参数名，则可以使用默认名称 newValue
 */
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// MARK: - 只读计算属性
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

// MARK: -  属相观察器
/*
 属性观察器监控和响应属性值的变化
 可以为除了延迟存储属性之外的其他存储属性添加属性观察器
 也可以通过重载属性的方式为继承的属性（包括存储属性和计算属性）添加
 note：不需要为无法重载的计算属性添加属性观察器，因为可以通过 setter 直接监控和响应值的变化
 */

/*
     willSet  在设置新的值之前调用
     didset 在新的值被设置之后立即调用
 */
class StepCounter {
    var totalSteps: Int = 0 {
    willSet(newTotalSteps){
        print("About to set totalSteps to \(newTotalSteps)")
    }
    didSet {
        //didSet  没有提供自定义名称，所以默认值 OldValue 表示旧值
        if totalSteps > oldValue {
            print("Added \(totalSteps - oldValue) steps")
            
            totalSteps = totalSteps - oldValue
        }
    }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360

print(stepCounter.totalSteps)

// MARK: - 全部变量和局部变量
/*
 全部变量是在函数、方法、闭包或任何类型之外定义的变量
 局部变量是在函数、方法或闭包内部定义的变量
 
 全局的常量或变量都是延迟计算的，所以不需要标记 lazy 特性
 */

// MARK: - 类型属性
/*
 实例的属性属于一个特定类型实例，每次类型实例化后都拥有自己的一套属性值，实例之间的属性相互独立
 类型本身定义属性，不管类型多少个实例，这些属性都有唯一一份
 用于定义特定类型所有实例共享的数据
 类（class） 只能定义计算类型属性，必须给存储类型属性指定默认值
 */

/*
  使用关键字 static 来定义值类型的类型属性
  使用关键字 class 来定义类型属性
 */

struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty:Int {
        return 100
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty:Int {
        return 100
    }
}
class SomeClass {
    class var computedTypeProperty: Int {
        return 100
    }
}

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)
rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)



