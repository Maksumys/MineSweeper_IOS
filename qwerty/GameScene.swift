//
//  GameScene.swift
//  qwerty
//
//  Created by Максим Кузин on 12.10.15.
//  Copyright (c) 2015 Максим Кузин. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var timeClock : SKLabelNode?
    var boolTimeClock : Bool = false
    var length_x : Int
    var length_y : Int
    var testX : CGFloat = 0
    var testY : CGFloat = 0
    var sprite_2 : SKSpriteNode
    var timesecond : Int = 0
    var touchedNumber : Int = -1
    var flag : [Int] = []
    
    let sweeper : Minesweeper = Minesweeper()
    
    init(size: CGSize, length_x: Int, length_y: Int) {
        self.length_x = length_x
        self.length_y = length_y
        sprite_2 = SKSpriteNode()
        sweeper.initial(length_x, length_x)
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func didMoveToView(view: SKView) {
        SceneSetting()
        SKSpriteNodeDemo()
        sweeper.addAllMine()
        sweeper.checkMine()
    }
    
    func SceneSetting() {
        self.backgroundColor = SKColor.grayColor()
    }
    
    func SKSpriteNodeDemo(){
        let backToMenu = SKLabelNode(fontNamed: "Chalkduster")
        backToMenu.position = CGPointMake(1400, 1950)  // задаем позицию.
        backToMenu.fontSize = 50 // задаем размер шрифта.
        backToMenu.fontColor = SKColor.whiteColor() // задаем цвет шрифта.
        backToMenu.color = SKColor.blueColor() // задаем цвет (Нужен для сочетание с colorBlendFactor).
        backToMenu.colorBlendFactor = 0.5 // задаем colorBlendFactor (0.0 - 1.0)
        backToMenu.text = "Back" // задаем текст.
        backToMenu.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center  // задаем способ выравнивание текста.
        backToMenu.name = "BackToMenu" // задаем имя спрайта
        self.addChild(backToMenu) // добавляем наш спрайт на нашу сцену.
        
        timeClock = SKLabelNode(fontNamed: "Chalkduster")
        timeClock!.position = CGPointMake(200, 1950)
        timeClock!.fontSize = 50 // задаем размер шрифта.
        timeClock!.fontColor = SKColor.whiteColor() // задаем цвет шрифта.
        timeClock!.color = SKColor.blueColor() // задаем цвет (Нужен для сочетание с colorBlendFactor).
        timeClock!.colorBlendFactor = 0.5 // задаем colorBlendFactor (0.0 - 1.0)
        timeClock!.text = "time: 00 : 00" // задаем текст.
        timeClock!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center  // задаем способ выравнивание текста.
        timeClock!.name = "time" // задаем имя спрайта
        self.addChild(timeClock!) // добавляем наш спрайт на нашу сцену.
        
        testX = (((self.size.width - 40)/CGFloat(length_x)))
        testY = (((self.size.width - 40)/CGFloat(length_y)))
        for i in 0..<length_x {
            for j in 0..<length_y {
                let sprite_1 = SKSpriteNode(imageNamed: "-3")
                sprite_1.size = CGSizeMake(testX, testX);
                sprite_1.name = String(i * length_x + j)
                sprite_1.position = CGPointMake(CGFloat(testX * CGFloat(i + 1) + 20 - testX/2), CGFloat(20 + CGFloat(j + 1) * testY - CGFloat(testY / 2)))
                addChild(sprite_1)
            }
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)

        
        let touch = touches
        let location = touch.first!.locationInNode(self)
        var touchedNode = self.nodeAtPoint(location)
        
        //если кнопка назад то выходим в главное меню
        //если это не бекграунд и не время, то запоминаем
        //номер нажатого и помечаем именем touched
        //запускаем отсчет времени 2 секунды для проверки на становление флага в ячейку
        //если флаг ставится, то возвращаем имя ячейки которое запомнили и меняем спрайт на флаг
        if (touchedNode.name == "BackToMenu") {
            self.removeAllChildren()
            let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
            let nextScene = MainMenu(size: scene!.size)
            nextScene.scaleMode = .AspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        }
        else if(touchedNode.name != self.name) && (touchedNode.name != "time") {
            var sch : Int = 0
            for elem in flag {
                if (elem == Int(touchedNode.name!)!) {
                    //меняем флаг на обычную ячейку и выходим
                    let sprite_4 = SKSpriteNode(imageNamed: "-3")
                    sprite_4.name = touchedNode.name
                    sprite_4.position = touchedNode.position
                    sprite_4.size = CGSizeMake(testX, testX);
                    touchedNode.removeFromParent()
                    addChild(sprite_4)
                    sweeper.cells[Int(touchedNode.name!)!].test = false
                    flag.removeAtIndex(sch)
                    return
                }
                sch++
            }
            
            if (sweeper.cells[Int(touchedNode.name!)!].test == false ) {
                touchedNumber = Int(touchedNode.name!)!
                sprite_2 = SKSpriteNode(imageNamed: "touched")
                sprite_2.name = "touched"
                sprite_2.position = touchedNode.position
                sprite_2.size = CGSizeMake(testX, testX);
                touchedNode.removeFromParent()
                addChild(sprite_2)
                
                touchedNode = self.nodeAtPoint(location)
                timesecond = 0
                let actionWait = SKAction.waitForDuration(0.3)
                let actionRun = SKAction.runBlock({
                    self.timesecond++
                    if (self.timesecond == 2) {
                        if (touchedNode.name == "touched") {
                            let sprite_3 = SKSpriteNode(imageNamed: "-2")
                            sprite_3.name = String(self.touchedNumber)
                            sprite_3.position = touchedNode.position
                            sprite_3.size = CGSizeMake(self.testX, self.testX)
                            touchedNode.removeFromParent()
                            self.addChild(sprite_3)
                            self.sweeper.cells[self.touchedNumber].test = true
                            self.flag.append(self.touchedNumber)
                        }
                    }
                })
                runAction(SKAction.repeatAction(SKAction.sequence([actionWait, actionRun]), count: 2))
            }
        }
    }
    
    
    /*override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
    }*/
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        let touch = touches 
        let location = touch.first!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        //если имя тачед, тогда возвращаем имя ячейке, и открываем ее
        if (touchedNode.name == "touched") {
            touchedNode.name = String(touchedNumber)
            let x : Int = touchedNumber
            let test = x % length_x
            let y = ((x - test) / length_x)
            if (open(x - (y * length_x), y) == -1) {
                removeAllChildren()
                let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
                let nextScene = GameOver(size: scene!.size)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }

        }
        updateClock()
    }
    
    
    func open(i: Int, _ j: Int) -> Int {
        
        // помечаем ячейку как пройденную
        sweeper.cells[j * length_x + i].test = true
        let string : String = String(sweeper.cells[j * length_x + i].elem)
        let sprite_1 = SKSpriteNode(imageNamed: string)
        testX = (((self.size.width - 40)/CGFloat(length_x)))-1
        sprite_1.size = CGSizeMake(testX, testX);
        sprite_1.name = String(j * length_x + i)
        let mySprite: SKSpriteNode = childNodeWithName(String(j * length_x + i)) as! SKSpriteNode
        sprite_1.position = mySprite.position
        mySprite.removeFromParent()
        addChild(sprite_1)
        
        var a : Int = 0
        var b : Int = 0
        var c : Int = 0
        var d : Int = 0
        
        if (sweeper.isMine(i, j)) {
            return -1 // Game over
        }
            
        (a, b, c, d) = sweeper.checkPosition(i, j)
        
        if (sweeper.isNumber(i, j)) {
            let rewq = sweeper.isEmptyAround(i, j)
            if (rewq.0)&&(sweeper.cells[rewq.2 * length_x + rewq.1].test == false) {
                if (open(rewq.1, rewq.2) == -1) {
                    return -1
                }
            }
        }
        else if (sweeper.isEmpty(i, j)) {
            for m in c ... d {
                for k in a ... b {
                    if (sweeper.cells[m * length_x + k].test == false) {
                        if (open(k, m) == -1) {
                            return -1
                        }
                    }
                }
            }
        }
        return -10
    }
    
    
    func updateClock() {
        if (boolTimeClock == false) {
            boolTimeClock = true
            var leadingZero = ""
            var leadingZeroMin = ""
            var timeMin : Int = 0
            let actionWait = SKAction.waitForDuration(1.0)
            var timesecond : Int = 0
            let actionrun = SKAction.runBlock({
                timeMin++
                timesecond++
                if timesecond == 60 {
                    timesecond = 0
                }
                if (timeMin / 60) <= 9 {
                    leadingZeroMin = "0"
                }
                else {
                    leadingZeroMin = ""
                }
                if timesecond <= 9 {
                    leadingZero = "0"
                }
                else {
                    leadingZero = ""
                }
                self.timeClock!.text = "time: \(leadingZeroMin)\(timeMin/60) : \(leadingZero)\(timesecond)"
            })
            self.timeClock?.runAction(SKAction.repeatActionForever(SKAction.sequence([actionWait,actionrun])))
        }
    }
}
