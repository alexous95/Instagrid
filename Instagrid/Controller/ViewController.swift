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
        setupSwipeGesture()
        setupButton()
    }

    
    //This is the function called in the selector from the SwipeGesture initializer 
    @objc private func swipeViewUp( _ sender : UISwipeGestureRecognizer ){
        switch sender.direction {
        // If direction is up then we call the transform function with
        case .up :
            print("ok haut")
            transformGridViewUpWith(gestureDirection : sender)
        default :
            break
        }
    }
    
    //This function create a translation movement for our view
    private func transformGridViewUpWith(gestureDirection : UISwipeGestureRecognizer){
        switch gestureDirection.direction {
        case .up:
            //We create a transformation to move the gridView out of the screen
            let translationTransform = CGAffineTransform(translationX: 0.0, y: -screenHeight)
            
            //Now we animate that transition with the animate method from UIView
            UIView.animate(withDuration: 1.0, animations: {
                self.gridView.transform = translationTransform
            }) { (success) in
                if success {
                    //if the animation is successful we call another function in the completion closure
                    print("c'est deja bien")
                    self.backGridView()
                }
            }
        default:
            break
        }
    }
    
    //This function brings back the gridView to his original location with a dumping effect
    private func backGridView(){
        gridView.transform = .identity
        gridView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: [], animations: {
            self.gridView.transform = .identity
        }, completion: nil)
    }
    
    private func setupSwipeGesture(){
        //We first create a swipeGestureRecognizer
        let swipeGestureRecongnizerUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeViewUp(_ :)))
        
        //We specify his direction
        swipeGestureRecongnizerUp.direction = .up

        //Then we had this gesture to the targeted view
        self.shareView.addGestureRecognizer(swipeGestureRecongnizerUp)
    }
    
    private func setupButton(){
        self.topRectangleButton.isHidden = true
        self.bottomLeftButton.isHidden = true
        self.bottomRightButton.isHidden = true
        
        self.topRectangleButton.tag = 1
        self.bottomRectangleButton.tag = 2
        self.bottomLeftButton.tag = 3
        self.bottomRightButton.tag = 4
        self.topLeftButton.tag = 5
        self.topRightButton.tag = 6
        
        self.layout1Button.tag = 10
        self.layout2Button.tag = 20
        self.layout2Button.setImage(UIImage(named: "rectangleDownSelected"), for: .normal)
        self.layout3Button.tag = 30
        
    }
    
    @IBAction func buttonWasPressed(_ sender : UIButton){
        switch sender.tag {
        case 10:
           changeLayout(layout: 1)
            sender.setImage(UIImage(named: "rectangleUpSelected"), for: .normal)
            layout2Button.setImage(UIImage(named: "layout2"), for: .normal)
            layout3Button.setImage(UIImage(named: "layout3"), for: .normal)
            
        case 20:
            changeLayout(layout: 2)
            sender.setImage(UIImage(named: "rectangleDownSelected"), for: .normal)
            layout1Button.setImage(UIImage(named: "layout1"), for: .normal)
            layout3Button.setImage(UIImage(named: "layout3"), for: .normal)
            
        case 30:
            changeLayout(layout: 3)
            sender.setImage(UIImage(named: "fourSquareSelected"), for: .normal)
            layout1Button.setImage(UIImage(named: "layout1"), for: .normal)
            layout2Button.setImage(UIImage(named: "layout2"), for: .normal)
        default:
            break
        }
    }
    
    private func changeLayout(layout : Int){
        switch layout {
        case 1:
            self.topRectangleButton.isHidden = false
            self.bottomLeftButton.isHidden = false
            self.bottomRightButton.isHidden = false
            self.topRightButton.isHidden = true
            self.topLeftButton.isHidden = true
            self.bottomRectangleButton.isHidden = true
            
        case 2:
            self.topRectangleButton.isHidden = true
            self.bottomLeftButton.isHidden = true
            self.bottomRightButton.isHidden = true
            self.topRightButton.isHidden = false
            self.topLeftButton.isHidden = false
            self.bottomRectangleButton.isHidden = false
            
        case 3:
            self.topRectangleButton.isHidden = true
            self.bottomLeftButton.isHidden = false
            self.bottomRightButton.isHidden = false
            self.topRightButton.isHidden = false
            self.topLeftButton.isHidden = false
            self.bottomRectangleButton.isHidden = true
            
        default:
            print("oops")
        }
    }
    
    
    
}

