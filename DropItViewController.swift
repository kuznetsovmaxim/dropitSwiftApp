//
//  DropItViewController.swift
//  DropIt
//
//  Created by Максим Кузнецов on 17.03.16.
//  Copyright © 2016 Kuznetsovmaxim. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController, UIDynamicAnimatorDelegate
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
    var dropsPerRow = 18
    var dropsPerColumn = 10
    
//    Должен делить высоту фрейма на дропсайз (ширина она же высота кубика) и получать значение переменной
    
//    Высчитываем размер объектов
    var dropSize: CGSize{
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)  /* Ширина и высота кубика */
    }
    
    var dropSizeHeight: CGSize{
        let sizeHeight = gameView.bounds.size.height / CGFloat(dropsPerColumn) /* Делю высоту фрейма на количество кубиков (должен не на количество кубиков, а на относительную их высоту равную полученной ранее ширине) */
        let sizeWidth = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: sizeWidth, height: sizeHeight)
    }
    
    
    @IBAction func btn(sender: UIButton) {
    
        drop()
        
    }
//    Создаем событие касания с логикой в отедльной функции drop()
    @IBAction func drop(sender: UITapGestureRecognizer) {
//        drop()
        
    }

    var indexOf: Int = 1

//    Функция отрисовки фигур и применения анимации
    func drop(){
     
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        
        gameView.addSubview(dropView)
        
        gravity.addItem(dropView)
        collider.addItem(dropView) 
        
        
//      Цикл генерации фигур
       
//        if indexOf < 10
//        {
            for indexOf = 1; indexOf <= 2; ++indexOf
            {
//                for cnt in 1...1
//                {
                    let delay = Int64( Double(1)/100 * Double(NSEC_PER_SEC) )
                    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
                    dispatch_after(dispatchTime, dispatch_get_main_queue())
                    {
                        self.drop()
                    }
//                }
                print(indexOf)
            }
//        }
   
        

        
        
//  ______________________________________________________________________________
//        for cnt in 1...1
//        {
//            if dropsPerColumn == 1
//            {
//                break
//            }
//            else
//            {
//                let delay = Int64( Double(cnt)/100 * Double(NSEC_PER_SEC) )
//                let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
//                dispatch_after(dispatchTime, dispatch_get_main_queue())
//                    {
//                        self.drop()
//                }
//            }
//        }
//        ___________________________________________________________________________
        
//        for cnt in 1...1
//        {
//            if indexOf < 10
//            {
//                for var indexOf = 0; indexOf == 10; ++indexOf
//                {
//                    let delay = Int64( Double(cnt)/100 * Double(NSEC_PER_SEC) )
//                    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
//                    dispatch_after(dispatchTime, dispatch_get_main_queue())
//                        {
//                            self.drop()
//                    }
//                }
//            }
//            else
//            {
//                break
//            }
//        }
        
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
        switch arc4random()%4 {
        case 0: return UIColor.blackColor()
        case 1: return UIColor.lightGrayColor()
        case 2: return UIColor.grayColor()
        case 3: return UIColor.darkGrayColor()
//        case 4: return UIColor.magentaColor()
        default: return UIColor.purpleColor()
        }
    }
}

















