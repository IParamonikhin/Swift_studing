//
//  ViewController.swift
//  sf_unit21_hw
//
//  Created by Иван on 20.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var elementViewOne: CustomView!
    @IBOutlet weak var elementViewTwo: CustomView!
    @IBOutlet weak var elementViewThree: CustomView!
    @IBOutlet weak var elementViewFour: CustomView!
    @IBOutlet weak var elementViewFive: CustomView!
    @IBOutlet weak var elementViewSix: CustomView!
    @IBOutlet weak var elementViewSeven: CustomView!
    

    var customViewArray = [CustomView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customViewArray.append(elementViewOne)
        customViewArray.append(elementViewTwo)
        customViewArray.append(elementViewThree)
        customViewArray.append(elementViewFour)
        customViewArray.append(elementViewFive)
        customViewArray.append(elementViewSix)
        customViewArray.append(elementViewSeven)
        }
    

    @IBAction func panAction(_ gesture: UIPanGestureRecognizer) {
        var isBig: Bool = false
        struct Capture{
            var x: Bool
            var y: Bool
        }

        let gestureTranslation = gesture.translation(in: view)

        guard let gestureView = gesture.view else { return }

        for index in 0...customViewArray.count - 1{
            if gestureView == customViewArray[index]{
                if customViewArray[index].isBig{
                    isBig = true
                }
            }
        }
        gestureView.center = CGPoint(x: gestureView.center.x + gestureTranslation.x, y: gestureView.center.y + gestureTranslation.y)
//        intersectionLogic(for: gestureView, isBig)
        for index in 0...customViewArray.count - 1{
            var capture: Capture = Capture(x: false, y: false)
            let enemyView = customViewArray[index]
            if !enemyView.isBig && !enemyView.isHidden && !isBig{
                if gestureView != enemyView{

                    for value in Int(enemyView.frame.minY)...Int(enemyView.frame.maxY) {
                        if Int(gestureView.center.y) == value {
                            capture.y = true
                        }
                    }
                    for value in Int(enemyView.frame.minX)...Int(enemyView.frame.maxX) {
                        if Int(gestureView.center.x) == value {
                            capture.x = true
                        }
                    }

                    if capture.x && capture.y{
                        enemyView.doBigger()
//                        enemyView.setBackgroundColor = .systemIndigo
                        gestureView.isHidden = true
                        capture.x = false
                        capture.y = false
                        enemyView.isBig = true
                    }
                }
            }
        }
        gesture.setTranslation(.zero, in: view)

        guard gesture.state == .ended else { return }


    }
//    private func intersectionLogic(for gestureView: UIView, _ isBig: Bool) {
//        for bubble in customViewArray {
//            if gestureView.frame.intersects(bubble.frame) && bubble !== gestureView && !bubble.isHidden && !isBig {
//                var maxFrame: CGRect = .zero
//                var animatedView: CustomView?
//                if gestureView.frame.size.width > bubble.frame.size.width {
//                    bubble.isHidden = true
//                    maxFrame = gestureView.frame
//                    animatedView = gestureView as? CustomView
//                  } else {
//                      gestureView.isHidden = true
//                      maxFrame = bubble.frame
//                      animatedView = bubble
//                  }
//                guard let animatedView = animatedView
//                else {
//                    return
//                }
//                animatedView.doBigger()
//                break }
//        }
//    }
}

