//
//  MemeEditor.swift
//  MemeMe
//
//  Created by Алексей Шпирко on 08/07/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func imageFromView() -> UIImage {
        
        UIGraphicsBeginImageContext(bounds.size)
        drawViewHierarchyInRect(bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}


class MemeEditor: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var fieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureField(bottomTextField, placeholder:"BOTTOM")
        configureField(topTextField,placeholder:"TOP")
        
        configureRecognizer()
        updateButtons()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromNotifications()
    }
    
    func updateButtons() {
        shareButton.enabled = imageView.image != nil
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(
        UIImagePickerControllerSourceType.Camera)
    }
    
    func configureRecognizer() {
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: "handleTap:")
        imageView.addGestureRecognizer(tap)
        
    }
    
    func configureField(field:UITextField, placeholder:String) {
        
        let string = NSMutableAttributedString(string: placeholder)
        string.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, string.length))
        string.addAttribute(NSFontAttributeName, value:UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, range: NSMakeRange(0, string.length))
        
        field.attributedPlaceholder = string
        field.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)
        field.textColor = UIColor.whiteColor()
    }
    
    //MARK: Actions
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickImage(sender: UIBarButtonItem) {
        
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func makeImage(sender: UIBarButtonItem) {
        
        let pickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera;
            pickerController.allowsEditing = false
            pickerController.cameraCaptureMode = .Photo
            presentViewController(pickerController, animated: true, completion: nil)
        }
        
    }
   
    
    @IBAction func sharePressed(sender: UIBarButtonItem) {
        
        let memedImage = generateMemeImage()
        var activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities:nil )
        activityViewController.completionWithItemsHandler = {
            
            (activity, success, items, error) in
            self.save()
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    func save() {
        
        var  meme = Meme(text: topTextField.text, image: imageView.image, memedImage: generateMemeImage())
        MemeStorage.sharedInstance.addMeme(meme)
    }
    
    func generateMemeImage() -> UIImage {
        
        showBars(false)
        
        let memeImage = view.imageFromView()
        
        showBars(true)
        
        return memeImage
    }
    
    
    func showBars(show:Bool) {
        
        toolbar.hidden = !show
        navigationController?.setNavigationBarHidden(!show, animated: false)
        
    }
    
   //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        imageView.image = image
        
        dismissViewControllerAnimated(true, completion: nil)
        
         updateButtons()
    }
    
    //MARK: Keyboard
    
    func subscribeToKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromNotifications() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomTextField.isFirstResponder() {
            fieldBottomConstraint.constant += getKeyboardHeight(notification)
        }
        
        view.layoutIfNeeded()
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        fieldBottomConstraint.constant = 0
        view.layoutIfNeeded()
    }
    
    func getKeyboardHeight(notification : NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // MARK : tap recognizer 
     func handleTap(sender: UITapGestureRecognizer) {
    
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
    
    }
    
    //MARK: UItextField delegates
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
}