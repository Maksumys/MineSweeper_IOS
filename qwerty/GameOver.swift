//
//  GameOver.swift
//  qwerty
//
//  Created by Максим Кузин on 15.10.15.
//  Copyright © 2015 Максим Кузин. All rights reserved.
//

import SpriteKit



class GameOver : SKScene {
    
    override func didMoveToView(view: SKView) {
        gameOver()
    }
    
    func gameOver() {
        let First = SKLabelNode(fontNamed: "Chalkduster")
        First.position = CGPointMake(self.size.width / 2, 2 * self.size.height / 3)  // задаем позицию.
        First.fontSize = 100 // задаем размер шрифта.
        First.fontColor = SKColor.redColor() // задаем цвет шрифта.
        First.color = SKColor.blueColor() // задаем цвет (Нужен для сочетание с colorBlendFactor).
        First.colorBlendFactor = 0.5 // задаем colorBlendFactor (0.0 - 1.0)
        First.text = "Game over!" // задаем текст.
        First.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center  // задаем способ выравнивание текста.
        First.name = "GameOver" // задаем имя спрайта
        self.addChild(First) // добавляем наш спрайт на нашу сцену.
        
        
        
        let Last = SKLabelNode(fontNamed: "Chalkduster")
        Last.position = CGPointMake(self.size.width / 2, 1 * self.size.height / 3)  // задаем позицию.
        Last.fontSize = 100 // задаем размер шрифта.
        Last.fontColor = SKColor.whiteColor() // задаем цвет шрифта.
        Last.color = SKColor.blueColor() // задаем цвет (Нужен для сочетание с colorBlendFactor).
        Last.colorBlendFactor = 0.5 // задаем colorBlendFactor (0.0 - 1.0)
        Last.text = "main menu" // задаем текст.
        Last.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center  // задаем способ выравнивание текста.
        Last.name = "back" // задаем имя спрайта
        self.addChild(Last) // добавляем наш спрайт на нашу сцену.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        let touch = touches
        let location = touch.first!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name == "back") {
            removeAllChildren()
            let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
            let nextScene = MainMenu(size: scene!.size)
            nextScene.scaleMode = .AspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        }
        
        
    }
}