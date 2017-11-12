//
//  main.swift
//  LearnSwiftForMethod
//
//  Created by susuyan on 2017/11/12.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 方法是与特定类型相关联的函数。
 
 类、结构体以及枚举均可以定义实例方法，该方法为指定类型的实例封装了特定的任务与功能
 也能定义类型方法，该方法与类型自身相关联
 
 */

// MARK: - 实例方法
/*
 实例方法是某个特定类、结构体或枚举类型的实例的方法
 他们通过提供访问的方式或修改实例属性

 实例方法要写在它所属的类型的前后括号之类
 */

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func increment(by amount:Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
    
}

let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

// MARK: - Self Property
/*
 类型的每一实例都有一个被称为 self 的隐含属性，该属性完全等同于该实例本身
 可以在一个实例的实例方法中使用这个隐含的 self 属性来引用当前实例
 
 */
struct Point1 {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
    
}

let somePoint = Point1(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

// MARK: - 在实例方法中修改值类型
/*
 结构体和枚举均属于值类型一般情况下，值类型的属性不能在其实例方法内被修改
 但是，如果在某个具体方法中，你需要对结构体或枚举的属性进行修改，你可以选择变异这个方法。（mutating）
 */

struct Point2 {
    var x  = 0.0, y = 0.0
    
    mutating func moveBy(x deltax:Double, y deltaY: Double){
        x += deltax
        y += deltaY
    }
}
var onePoint = Point2(x: 1.0, y: 1.0)
onePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(onePoint.x),\(onePoint.y))")

let fixedPoint = Point2(x: 3.0, y: 3.0)
// 实例常量，修改属性值，会报错
//fixedPoint.moveBy(x: 2.0, y: 3.0)

// MARK: - 在变异方法中给 self 赋值
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
    
}



































