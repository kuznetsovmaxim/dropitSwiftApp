//
//  DropItViewController.swift
//  DropIt
//
//  Created by Максим Кузнецов on 17.03.16.
//  Copyright © 2016 Kuznetsovmaxim. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController
{

    @IBOutlet weak var gameView: UIView!
    
//    Объявляем переменную гравитации
    let gravity = UIGravityBehavior()
    
//    Создаем нижнюю границу - барьер
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
    }()
    
    lazy var animator: UIDynamicAnimator = {
    let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        return lazilyCreatedDynamicAnimator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
        
    }
    
    
    
//    Количество фигурок в ряд
    var dropsPerRow = 10
    
//    Высчитываем размер объектов
    var dropSize: CGSize{
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    @IBAction func btn(sender: UIButton) {
    
        drop()
        
    }
//    Создаем событие касания с логикой в отедльной функции drop()
    @IBAction func drop(sender: UITapGestureRecognizer) {
//        drop()
        
    }

    

//    Функция отрисовки фигур и применения анимации
    func drop(){
     
           var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        
        gameView.addSubview(dropView)
        
        gravity.addItem(dropView)
        collider.addItem(dropView) 
        
        
 
        
//        Цикл
        for count in 1...2 {
            
            let delay = Int64( Double(count) * Double(NSEC_PER_SEC) * 5)
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
            dispatch_after(dispatchTime, dispatch_get_main_queue()) {
                self.drop()
                
                
            }
        }
        
    }
    
    
    
    
    
    
}




// Создаем метод в котором рассчитывается рандомное число между единицей количеством фигур в ряду минус 1 (?)
private extension CGFloat{
    static func random(max: Int) -> CGFloat{
        return CGFloat(arc4random() % UInt32(max))
    }
}

// Создаем метод для рандомной раскраски объектов
private extension UIColor{
    class var random: UIColor {
        switch arc4random()%5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.magentaColor()
        default: return UIColor.blackColor()
        }
    }
}

















