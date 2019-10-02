//
//  ViewController.swift
//  Instagrid
//
//  Created by Alexandre Goncalves on 02/10/2019.
//  Copyright © 2019 Alexandre Goncalves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shareView: ShareView!
    @IBOutlet weak var gridView: UIView!
    
    
    @IBOutlet weak var topRectangleButton: UIButton!
    @IBOutlet weak var bottomRectangleButton: UIButton!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    @IBOutlet weak var layout1Button: UIButton!
    @IBOutlet weak var layout2Button: UIButton!
    @IBOutlet weak var layout3Button: UIButton!
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth  = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGestureRecongnizerUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeViewUp(_ :)))
        swipeGestureRecongnizerUp.direction = .up
        //let swipeGestureRecongnizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_ :)))
        //swipeGestureRecongnizerUp.direction = .left
        self.shareView.addGestureRecognizer(swipeGestureRecongnizerUp)
        //self.shareView.addGestureRecognizer(swipeGestureRecongnizerLeft)
    }

    
    @objc private func swipeViewUp( _ sender : UISwipeGestureRecognizer ){
        switch sender.direction {
        case .up :
            print("ok haut")
            transformGridViewUpWith(gestureDirection : sender)
        default :
            break
        }
    }
    
    private func transformGridViewUpWith(gestureDirection : UISwipeGestureRecognizer){
        switch gestureDirection.direction {
        case .up:
            let translationTransform = CGAffineTransform(translationX: 0.0, y: -screenHeight)
            
            UIView.animate(withDuration: 1.0, animations: {
                self.gridView.transform = translationTransform
            }) { (success) in
                if success {
                    print("c'est deja bien")
                    self.backGridView()
                }
            }
        default:
            break
        }
    }
    
    private func backGridView(){
        gridView.transform = .identity
        gridView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: [], animations: {
            self.gridView.transform = .identity
        }, completion: nil)
    }
    
}

