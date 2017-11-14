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










