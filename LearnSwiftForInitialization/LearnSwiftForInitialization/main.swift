//
//  main.swift
//  LearnSwiftForInitialization
//
//  Created by susuyan on 2017/11/10.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK: -  模块说明
// FIXME: - Fix
// TODO: - TODO


// MARK: - Initialization
/*
 “构造过程是为了使用某个类、结构体或枚举类型的实例而进行的准备过程。这个过程包含了为实例中的每个属性设置初始值和为其执行必要的准备和初始化任务”
 “构造过程是通过定义构造器（Initializers）来实现的，这些构造器可以看做是用来创建特定类型实例的特殊方法。
 与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化。
 类实例也可以通过定义析构器（deinitializer）在类实例释放之前执行特定的清除工作。”
 
 */
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
//print("The Default temperature is \(f.temperature)")

struct Celsius {
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ OnePoint:Double) {
        temperatureInCelsius = OnePoint
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
let OnePointOfWater = Celsius(100.0)

//print("BoilingPointOfWater is \(boilingPointOfWater) \nFreezingPointOfWater is \(freezingPointOfWater)\nOnePointOfWater is \(OnePointOfWater)")

class SurveyQuestion {
    
    var text: String
    var response: String?
    
    
    init(text: String) {
        
        self.text = text
    }
    
    func ask() {
        
        print(text)
    }
    
}

let cheeseQuestion =  SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()

let beetsQuestion = SurveyQuestion(text:"How about beets?")
beetsQuestion.ask()

class ShoppingListItem1 {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem1()

//Struct Default Initialization
struct Size {
    var width = 0.0
    var height = 0.0
    //var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

struct Point {
    var x = 0.0 , y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center:Point, size:Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        self.init(origin: Point(x: originX, y: originY), size: size)
        
    }
}
let basicRect = Rect()

let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 4.0, height: 4.0))


class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "Unnamed")
    }
}


let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

print("namedMeat:\(namedMeat.name),mysteryMeat:\(mysteryMeat.name)")

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}


let oneMysteryItem = RecipeIngredient()

print(oneMysteryItem.name)

class ShoppingListItem:RecipeIngredient  {
    
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name.lowercased())"
        output += purchased ? "√":"×"
        return output
        
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

// MARK - 失败构造器

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
        
    }
}

let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}


// MARK - 可失败枚举构造器
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed")
}


// MARK - 类的可失败构造器
class Product {
    let name: String!
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
    
}

if let bowTie = Product(name: "bow tie"){
    print("The product's name is \(bowTie.name)")
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2){
    
    print("Item:\(twoSocks.name),quantity:\(twoSocks.quantity)")
    
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("item:\(zeroShirts.name),quantity:\(zeroShirts.quantity)")
}else {
    print("Unable to initialize zero shirts")
}

if let oneUnnamed = CartItem(name:"", quantity: 1){
    print("item:\(oneUnnamed.name),quantity:\(oneUnnamed.quantity)")
}else {
    print("Unable to initialize one unnamed product")
}


class Document {
    var name: String?
    init() {}
    
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        }else {
            self.name = name
        }
    }
}

// MARK - 必要构造器
//class SomeClass {
//    required init() {
//
//    }
//}
//
//class SomeSubclass: SomeClass {
//    required init() {
//
//    }
//}

// MARK -  通过闭包和函数来设置属性的默认值

//class SomeClass {
//    let someProperty: SomeType = {
//        // 在这个闭包中给 someProperty 创建一个默认值
//        // someValue 必须和 SomeType 类型相同”
//        return someValue
//    }()
//}
// ”如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。”

struct Checkerboard {
    let boardColors:[Bool] = {
        
        var temporaryboard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryboard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryboard
        
    }()
    
    func squarelsBlackAtRow(row:Int, column:Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

let board = Checkerboard()
print(board.squarelsBlackAtRow(row: 0, column: 1))

// MARK - 析构过程原理 （Deinitialization）
/*
 Swift 会自动释放不再需要的实例以释放资源。
 通常当你的实例被释放时不需要手动地去清理。但是，
 当使用自己的资源时，你可能需要进行一些额外的清理。例如，
 如果创建了一个自定义类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前关闭该文件
 
 在类的定义中，每个类最多只能有一个析构函数
 
 */

//deinit {
//    //执行析构过程
//}

/*
 析构函数是在实例释放发生前一步被自动调用。不允许主动调用自己的析构函数
 */
struct Bank {
    static var coinsInBank = 10_000
    static func vendCoins( numberOfCoinsToVend: Int) -> Int {
        var numberOfCoinsToVend = numberOfCoinsToVend
        numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(numberOfCoinsToVend: coins)
    }
    
    func winCoins(coins: Int){
        coinsInPurse += Bank.vendCoins(numberOfCoinsToVend: coins)
    }
    
    deinit {
        Bank.receiveCoins(coins: coinsInPurse)
    }
}


var playerOne: Player? = Player(coins: 100)

print("A new player has joined the game with\(playerOne!.coinsInPurse)")
print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.winCoins(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne = nil
print("PlayerOne has left the game")
print("There are now \(Bank.coinsInBank) coins left in the bank")
