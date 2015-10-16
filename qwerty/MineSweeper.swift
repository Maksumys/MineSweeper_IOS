//
//  File.swift
//  qwerty
//
//  Created by Максим Кузин on 13.10.15.
//  Copyright © 2015 Максим Кузин. All rights reserved.
//

import SpriteKit

// Type_cell
//-2 - flag
//-1 - mine
// 0 - empty
// 1 - ...
// 2 - ...

//ячейка
struct cell {
    var elem : Int
    var test : Bool
    init() {
        elem = 0
        test = false
    }
}

//поле
class Minesweeper {
    var cells : [cell] = []
    var length_x : Int = 0
    var length_y : Int = 0
    
    init(){}
    
    init(length_x : Int, length_y: Int) {
        cells = [cell](count: length_x * length_y, repeatedValue: cell())
        self.length_x = length_x
        self.length_y = length_y
    }
    
    func initial(length_x : Int, _ length_y: Int) {
        cells = [cell](count: length_x * length_y, repeatedValue: cell())
        self.length_x = length_x
        self.length_y = length_y
    }
    
    func addMine() {
        var i,j : Int
        
        repeat {
            i = Int(arc4random_uniform(UInt32(length_x - 1)))
            j = Int(arc4random_uniform(UInt32(length_y - 1)))
        } while(isMine(i, j))
        
        cells[length_x * j + i].elem = -1
    }
    
    func addAllMine() {
        if (length_x * length_y) == 81 {
            for _ in 1...9 {
                addMine()
            }
        }
        else if (length_x * length_y) == 256 {
            for _ in 1...40 {
                addMine()
            }
        }
        else if (length_x * length_y) == 625 {
            for _ in 1...150 {
                addMine()
            }
        }
    }
    
    func isMine(i : Int, _ j : Int) -> Bool {
        return (cells[j * length_x + i].elem == -1)
    }
    
    func isNumber(i : Int, _ j : Int) -> Bool {
        return (cells[j * length_x + i].elem > 0)
    }
    
    
    func isEmpty(i : Int, _ j : Int) -> Bool {
        return (cells[j * length_x + i].elem == 0)
    }
    
    //проверяет есть ли вокруг ячейки пустая ячейка
    func isEmptyAround(i : Int, _ j : Int) -> (Bool , Int, Int) {
        var a : Int = 0
        var b : Int = 0
        var c : Int = 0
        var d : Int = 0
        
        (a, b, c, d) = checkPosition(i, j)
        
        for m in c...d {
            for k in a...b {
                if ( k != i ) && ( m != j ) && isEmpty(k, m) {
                    return (true, k , m)
                }
            }
        }
        return (false, -1, -1)
    }
    
    //расставляет номера вокруг мин и предотвращает коллапс мин
    func checkMine() {
        for j in 0...length_y - 1 {
            for i in 0...length_x - 1 {
                var a : Int = 0
                var b : Int = 0
                var c : Int = 0
                var d : Int = 0
                
                (a, b, c, d) = checkPosition(i, j)
                var numberOfMine : Int = 0
                for m in c...d {
                    for k in a...b {
                        if(isMine(k, m)) {
                            numberOfMine++
                        }
                    }
                }
                
                if (isMine(i, j))&&(numberOfMine == 8) {
                    cells[length_x * j + i].elem = 0
                    addMine()
                }
                else if !isMine(i, j) {
                    cells[length_x * j + i].elem = numberOfMine
                }
            }
        }
    }
    
    //проверяем элемент и возвращаем интервалы позиций a...b, c...d, которые можно проверять вокруг этого элемента
    func checkPosition(i: Int, _ j: Int) -> (a: Int, b: Int, c: Int, d : Int) {
        if (i > 0) && (j > 0) && (i < length_x - 1) && (j < length_y - 1) {
            return (i - 1, i + 1, j - 1, j + 1)
        }
        else if (i == 0) && (j == 0) {
            return (i, i + 1, j, j + 1)
        }
        else if (i == length_x - 1) && (j == 0) {
            return (i - 1, i, j, j + 1)
        }
        else if (i == 0) && (j == length_y - 1) {
            return (i, i + 1, j - 1, j)
        }
        else if (i == length_x - 1)&&(j == length_y - 1) {
            return (i - 1, i, j - 1, j)
        }
        else if(i > 0) && (i < length_x - 1) && (j == 0) {
            return (i - 1, i + 1, j, j + 1)
        }
        else if (i == 0) && (j > 0) && (j < length_y - 1) {
            return (i, i + 1, j - 1, j + 1)
        }
        else if (i > 0) && (i < length_x - 1) && (j == length_y - 1)  {
            return (i - 1, i + 1, j - 1, j)
        }
        else if (i == length_x - 1) && (j > 0) && (j < length_y - 1) {
            return (i - 1, i, j - 1, j + 1)
        }
        else {
            return (-1,-1,-1,-1)
        }
    }
}