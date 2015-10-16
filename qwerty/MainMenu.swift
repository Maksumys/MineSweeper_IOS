//
//  File.swift
//  qwerty
//
//  Created by Максим Кузин on 13.10.15.
//  Copyright © 2015 Максим Кузин. All rights reserved.
//

import SpriteKit



class MainMenu : SKScene {
    
    override func didMoveToView(view: SKView) {
        sceneSetting()
        menu()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            if (touchedNode.name == "NewGame") {
                self.removeAllChildren()
                levels()
            }
            else if (touchedNode.name == "Easy") {
                removeAllChildren()
                let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
                let nextScene = GameScene(size: scene!.size, length_x: 9, length_y: 9)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if (touchedNode.name == "Medium") {
                removeAllChildren()
                let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
                let nextScene = GameScene(size: scene!.size, length_x: 16, length_y: 16)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if (touchedNode.name == "Hard") {
                removeAllChildren()
                let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
                let nextScene = GameScene(size: scene!.size,  length_x: 25, length_y: 25)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
        }
    }
    
    func sceneSetting() {
        self.backgroundColor = SKColor.grayColor()
    }
    
    func menu() {
        let First = SKLabelNode(fontNamed: "Chalkduster")
        First.position = CGPointMake(self.size.width / 2, 2 * self.size.height / 3)  // задаем позицию.
        First.fontSize = 100 // задаем размер шрифта.
        First.fontColor = SKColor.whiteColor() // задаем цвет шрифта.
        First.color = SKColor.blueColor() // задаем цвет (Нужен для сочетание с colorBlendFactor).
        First.colorBlendFactor = 0.5 // задаем colorBlendFactor (0.0 - 1.0)
        First.text = "New game" // задаем текст.
        First.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center  // задаем способ выравнивание текста.
        First.name = "NewGame" // задаем имя спрайта
        self.addChild(First) // добавляем наш спрайт на нашу сцену.
    }
    
    func levels() {
        let easy = SKLabelNode(fontNamed: "Chalkduster")
        let medium = SKLabelNode(fontNamed: "Chalkduster")
        let hard = SKLabelNode(fontNamed: "Chalkduster")
        
        easy.position = CGPointMake(self.size.width / 2, 2 * self.size.height / 3)
        medium.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        hard.position = CGPointMake(self.size.width / 2, 1 * self.size.height / 3)
        
        easy.fontSize = 100
        medium.fontSize = 100
        hard.fontSize = 100
        
        easy.fontColor = SKColor.whiteColor()
        medium.fontColor = SKColor.whiteColor()
        hard.fontColor = SKColor.whiteColor()
        
        easy.color = SKColor.blueColor()
        medium.color = SKColor.blueColor()
        hard.color = SKColor.blueColor()
        
        easy.colorBlendFactor = 0.5
        medium.colorBlendFactor = 0.5
        hard.colorBlendFactor = 0.5
        
        easy.text = "Easy"
        medium.text = "Medium"
        hard.text = "Hard"
        
        easy.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        medium.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        hard.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        
        easy.name = "Easy"
        medium.name = "Medium"
        hard.name = "Hard"
        
        self.addChild(easy)
        self.addChild(medium)
        self.addChild(hard)
    }
    
}



