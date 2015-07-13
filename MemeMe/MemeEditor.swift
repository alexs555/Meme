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
        
        UIGraphicsBeginImageContext(self.bounds.size)
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
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
        
        configureField(self.bottomTextField, placeholder:"BOTTOM")
        configureField(self.topTextField,placeholder:"TOP")
        
        configureRecognizer()
        updateButtons()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unsubscribeFromNotifications()
    }
    
    func updateButtons() {
        self.shareButton.enabled = self.imageView.image != nil
        self.cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(
        UIImagePickerControllerSourceType.Camera)
    }
    
    func configureRecognizer() {
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: "handleTap:")
        self.imageView.addGestureRecognizer(tap)
        
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
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickImage(sender: UIBarButtonItem) {
        
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func sharePressed(sender: UIBarButtonItem) {
        
        let memedImage = generateMemeImage()
        var activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities:nil )
        activityViewController.completionWithItemsHandler = {
            
            (activity, success, items, error) in
            self.save()
            
        }
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    func save() {
        
        var  meme = Meme(text: self.topTextField.text, image: self.imageView.image, memedImage: generateMemeImage())
        MemeStorage.sharedInstance.addMeme(meme)
    }
    
    func generateMemeImage() -> UIImage {
        
        showBars(false)
        
        let memeImage = self.view.imageFromView()
        
        showBars(true)
        
        return memeImage
    }
    
    
    func showBars(show:Bool) {
        
        self.toolbar.hidden = !show
        self.navigationController?.setNavigationBarHidden(!show, animated: false)
        
    }
    
   //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.imageView.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
            self.fieldBottomConstraint.constant += getKeyboardHeight(notification)
        }
        
        self.view.layoutIfNeeded()
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        self.fieldBottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    func getKeyboardHeight(notification : NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // MARK : tap recognizer
     func handleTap(sender: UITapGestureRecognizer) {
    
        self.topTextField.resignFirstResponder()
        self.bottomTextField.resignFirstResponder()
    
    }
    
    //MARK: UItextField delegates
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
}