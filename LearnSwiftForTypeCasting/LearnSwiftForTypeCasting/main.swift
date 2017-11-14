//
//  main.swift
//  LearnSwiftForTypeCasting
//
//  Created by susuyan on 2017/11/13.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

print("Hello, World!")

/*
 类型转换可以判断实例的类型
 使用操作符 is 和 as 实现
 */

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// MARK: - 检查类型（Checking Type）
/*
 用类型检查操作符（is） 来检查一个实例是否属于特定子类型，
 若实例属于那个字类型，则返回 true，否则返回 false
 */
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    }else if item is Song {
        songCount += 1
    }
}

print("Meida library contains \(movieCount) movies and \(songCount) songs")

// MARK: - 向下转型
/*
 某类型的一个常量或变量可能在幕后实际上属于一个子类
 当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as？或 as！）
 条件形式 as？返回一个你试图向下转成的类型的可选值
 强制形式 as！把试图向下转型或强制解包
 */

for item in library {
    if let movie = item as? Movie {
        print("Movie:'\(movie.name)',dir.\(movie.director)")
    }else if let song = item as? Song{
        print("Song:'\(song.name)',by \(song.artist)")
    }
}

// MARK: - Any 和 AnyObject 的类型转换
/*
 Swift 为不确定类型提供了两种特殊的类型别名
 Any 可以表示任何类型，包括函数类型
 AnyObject 可以表示任何类类型的实例
 */

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })


for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
        
    default:
        print("something else")
    }
    
}

/*
 注意：
 Any 类型可以表示所有类型的值，包括可选型。Swift会在你用Any类型来表示一个可选值的时候，给你一个警告
 如果你确实想使用Any类型来承载可选值，你可以使用as操作符显示转换为Any
  */
let optionalNumber: Int? = 3
//things.append(optionalNumber)  // 警告

//things.append(optionalNumber as Any) // 没有警告























