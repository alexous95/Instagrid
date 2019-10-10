//
//  ViewController.swift
//  Instagrid
//
//  Created by Alexandre Goncalves on 02/10/2019.
//  Copyright © 2019 Alexandre Goncalves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - OUTLETS
    
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
    
    var buttonPressed = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeGesture()
        setupButton()
    }

    
    //MARK: - PRIVATE
    
    //This is the function called in the selector from the SwipeGesture initializer 
    @objc private func swipeView( _ sender : UISwipeGestureRecognizer ){
        switch sender.direction {
        // If direction is up then we call the transform function with
        case .up :
            print("ok haut")
            transformGridViewWith(gestureDirection : sender)
        case .left:
            print("gauche ok")
            transformGridViewWith(gestureDirection: sender)
        default :
            break
        }
    }
    
   
    
    //This function create a translation movement for our view
    private func transformGridViewWith(gestureDirection : UISwipeGestureRecognizer){
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
                    
                    //This method allows us to create a UIImage from the view choosen
                    let renderer = UIGraphicsImageRenderer(size: self.gridView.bounds.size)
                    let image = renderer.image { contex in
                        self.gridView.drawHierarchy(in: self.gridView.bounds, afterScreenUpdates: true)
                    }
                    self.shareGridView(image: image)
                }
            }
            
        case .left :
            let translationTransform = CGAffineTransform(translationX: -screenWidth*2, y: 0.0)
            
            //Now we animate that transition with the animate method from UIView
            UIView.animate(withDuration: 1.0, animations: {
                self.gridView.transform = translationTransform
            }) { (success) in
                if success {
                    //if the animation is successful we call another function in the completion closure
                    let renderer = UIGraphicsImageRenderer(size: self.gridView.bounds.size)
                    let image = renderer.image { contex in
                        self.gridView.drawHierarchy(in: self.gridView.bounds, afterScreenUpdates: true)
                    }
                    self.shareGridView(image: image)
                }
            }
        default:
            break
        }
    }
    
    private func shareGridView(image : UIImage){
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.completionWithItemsHandler = {(UIActivityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                self.backGridView()
        }
        present(activityController, animated: true, completion: nil)
    }
    
    //This function brings back the gridView to his original location with a dumping effect
    private func backGridView(){
        gridView.transform = .identity
        gridView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2, options: [], animations: {
            self.gridView.transform = .identity
            self.originalGridView()
        }, completion: nil)
    }
    
    //This functions brings back the grid view to its original state
    private func originalGridView(){
        self.topRectangleButton.setImage(UIImage(named: "plus"), for: .normal)
        self.bottomRectangleButton.setImage(UIImage(named: "plus"), for: .normal)
        self.bottomLeftButton.setImage(UIImage(named: "plus"), for: .normal)
        self.bottomRightButton.setImage(UIImage(named: "plus"), for: .normal)
        self.topLeftButton.setImage(UIImage(named: "plus"), for: .normal)
        self.topRightButton.setImage(UIImage(named: "plus"), for: .normal)
    }
    
    private func setupSwipeGesture(){
        //We first create a swipeGestureRecognizer
        let swipeGestureRecongnizerUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        //We specify his direction
        swipeGestureRecongnizerUp.direction = .up
        swipeGestureRecognizerLeft.direction = .left

        //Then we had this gesture to the targeted view
        self.shareView.addGestureRecognizer(swipeGestureRecongnizerUp)
        self.shareView.addGestureRecognizer(swipeGestureRecognizerLeft)
    }
    
    // This function is used to setup the button and to give them tags so they can be recognized
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
    
    // This function is used to change the layout
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
    
    //MARK: - ACTIONS
    
    @IBAction func buttonLayoutWasPressed(_ sender : UIButton){
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
    
    @IBAction func buttonImagePickerWasPressed(_ sender : UIButton){
        self.buttonPressed = sender
        showImagePickerActionSheet()
    }
}

// MARK: - EXTENSIONS
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // This function is used to present an actionSheet to let the user choose between different options
    private func showImagePickerActionSheet(){
        let photoLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take from Camera", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let alert = UIAlertController(title: "Choose an options", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    /* We create a function that takes in parameter a source type from UIImagePickerController (.photoLibrary, .camera) and shows the image picker after a few configuration */
    private func showImagePickerController( sourceType : UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.buttonPressed.setImage(editedImage, for: .normal)
        }
        else if let originalImage = info[.originalImage] as? UIImage {
            self.buttonPressed.setImage(originalImage, for: .normal)
        }
        else {
            print("Pas d'immage")
            return
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

