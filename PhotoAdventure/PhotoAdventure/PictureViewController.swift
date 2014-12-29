//
//  PictureViewController.swift
//  PhotoAdventure
//
//  Created by James on 11/30/14.
//  Copyright (c) 2014 Bo Ning. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate{
    
    var leftEyePos: CGPoint = CGPointMake(0.0, 0.0)
    var rightEyePos: CGPoint = CGPointMake(0.0, 0.0)
    var mouthPos: CGPoint = CGPointMake(0.0, 0.0)
    var photo: UIImage = UIImage()
    @IBOutlet var pictureImageView: UIImageView!
    
    
    @IBAction func nextButton(sender: AnyObject) {
        if (GameCharactor.hasPhoto == false) {
            return
        }
        getFaceComponents()
        GameCharactor.leftEyeImage = changeFaceBackground(GameCharactor.leftEyeImage)
        // pictureImageView.image = GameCharactor.leftEyeImage

        GameCharactor.rightEyeImage = changeFaceBackground(GameCharactor.rightEyeImage)
        GameCharactor.mouthImage = changeFaceBackground(GameCharactor.mouthImage)
    }
    
    
    @IBAction func sexSelectButton(sender: AnyObject) {
        if (GameCharactor.gameCharGender == 0) {
            GameCharactor.gameCharGender = 1
            println("male")
        } else {
            GameCharactor.gameCharGender = 0
            println("female")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.pictureImageView.image == nil) {
            self.pictureImageView.image = UIImage(named: "no_image.jpg")
        }
        GameCharactor.gameCharGender = 0;
        GameCharactor.hasPhoto = false
    }
    
    @IBAction func selectImageButton(sender: AnyObject) {
        var actionSheet: UIActionSheet = UIActionSheet(title: "Photo Picker",
            delegate: self,
            cancelButtonTitle: "Cancel",
            destructiveButtonTitle: nil,
            otherButtonTitles: "Photo Library",
            "Take Photo")
        actionSheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        // user selected cancel
        if(buttonIndex == 0) {
            self.pictureImageView.image = UIImage(named: "cage.jpg")
            faceDetect()
            return
        }
        var imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        // default to selecting photo from photolibrary
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        // if the user selected camera and the camera is available
        if(buttonIndex == 2 && UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        // Show the image picker
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image: UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
        dismissViewControllerAnimated(true, completion: nil)
        self.pictureImageView.image = image
        faceDetect()
    }
    
    func faceDetect() {
        var ciImage = CIImage(CGImage: pictureImageView.image.CGImage)
        var ciDetector = CIDetector(ofType:CIDetectorTypeFace, context:nil
            , options:[CIDetectorAccuracy:CIDetectorAccuracyHigh, CIDetectorSmile: true])
        var features = ciDetector.featuresInImage(ciImage)
        if (features.count == 0) {
            GameCharactor.hasPhoto = false
            var alert = UIAlertController(title: "Warning", message: "No face detected! Try another photo or start anyway!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        if (features.count > 1) {
            var alert = UIAlertController(title: "Warning", message: "More than one face detected! Try another photo or start anyway!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            GameCharactor.hasPhoto = false
            return
        }
        GameCharactor.hasPhoto = true
        photo = pictureImageView.image
        UIGraphicsBeginImageContext(pictureImageView.image.size)
        pictureImageView.image.drawInRect(CGRectMake(0, 0, pictureImageView.image.size.width, pictureImageView.image.size.height))
        
        for feature in features{
            
            //context
            var drawCtxt = UIGraphicsGetCurrentContext()
            
            //face
            var faceRect = (feature as CIFaceFeature).bounds
            faceRect.origin.y = pictureImageView.image.size.height - faceRect.origin.y - faceRect.size.height
            CGContextSetStrokeColorWithColor(drawCtxt, UIColor.redColor().CGColor)
            CGContextStrokeRect(drawCtxt,faceRect)
            
            //mouth
            if((feature.hasMouthPosition) != nil){
                var mouthRectY = pictureImageView.image.size.height - feature.mouthPosition.y
                var mouthRect  = CGRectMake(feature.mouthPosition.x - 5,mouthRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.blueColor().CGColor)
                CGContextStrokeRect(drawCtxt, mouthRect)
                mouthPos = feature.mouthPosition
                print("mouth pos: ")
                print(mouthPos)
                print("\n")
            }
            
            //leftEye
            if((feature.hasLeftEyePosition) != nil){
                var leftEyeRectY = pictureImageView.image.size.height - feature.leftEyePosition.y
                var leftEyeRect = CGRectMake(feature.leftEyePosition.x - 5, leftEyeRectY - 5, 10, 10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.blueColor().CGColor)
                CGContextStrokeRect(drawCtxt, leftEyeRect)
                leftEyePos = feature.leftEyePosition
                print("left eye pos: ")
                print(leftEyePos)
                print("\n")
            }
            
            //rightEye
            if((feature.hasRightEyePosition) != nil){
                var rightEyeRectY = pictureImageView.image.size.height - feature.rightEyePosition.y
                var rightEyeRect  = CGRectMake(feature.rightEyePosition.x - 5, rightEyeRectY - 5, 10, 10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.blueColor().CGColor)
                CGContextStrokeRect(drawCtxt, rightEyeRect)
                rightEyePos = feature.rightEyePosition
                print("right eye pos: ")
                print(rightEyePos)
                print("\n")
            }
        }
        var drawedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        pictureImageView.image = drawedImage
        println("face detection done!")
    }
    
    
    func getFaceComponents() {
        var eyeDist = abs(leftEyePos.x - rightEyePos.x)
        var eyeMouthDist = abs(mouthPos.y - 0.5 * (leftEyePos.y + rightEyePos.y))
        var avgEyeY = 0.5 * (leftEyePos.y + rightEyePos.y)
        var leftEyeRect = CGRectMake(leftEyePos.x - 0.4 * eyeDist, photo.size.height - leftEyePos.y - 0.5 * eyeDist, 0.9 * eyeDist, eyeDist)
        GameCharactor.leftEyeImage = UIImage(CGImage: CGImageCreateWithImageInRect(photo.CGImage, leftEyeRect))
        var rightEyeRect = CGRectMake(rightEyePos.x - 0.5 * eyeDist, photo.size.height - rightEyePos.y - 0.5 * eyeDist, 0.9 * eyeDist, eyeDist)
        GameCharactor.rightEyeImage = UIImage(CGImage: CGImageCreateWithImageInRect(photo.CGImage, rightEyeRect))
        var mouthY = eyeMouthDist - 0.5 * eyeDist
        var mouthRect = CGRectMake(mouthPos.x - 0.5 * eyeDist, photo.size.height - mouthPos.y - mouthY, eyeDist, 1.6 * mouthY)
        GameCharactor.mouthImage = UIImage(CGImage: CGImageCreateWithImageInRect(photo.CGImage, mouthRect))
        println("face comps got")
    }
    
    func changeFaceBackground(srcImg: UIImage) -> UIImage {
        var srcImgRect = CGRectMake(0, 0, srcImg.size.width, srcImg.size.height)
        UIGraphicsBeginImageContext(srcImg.size)
        var context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, srcImg.size.height)
        CGContextScaleCTM(context, 1, -1)
        CGContextSaveGState(context)
        CGContextDrawImage(context, srcImgRect, srcImg.CGImage)
        var pxlData = CGDataProviderCopyData(CGImageGetDataProvider(srcImg.CGImage))
        var data = CFDataGetBytePtr(pxlData)
        var x: Int = 0
        var sumRGB: Array<UInt32> = Array<UInt32>()
        for (x = 0; x < Int(srcImg.size.width); x++) {
            var y: Int = 0
            for (y = 0; y < Int(srcImg.size.height); y++) {
                var pixelInfo: Int = ((Int(srcImg.size.width) * Int(y)) + Int(x)) * 4
                var r = data[pixelInfo]
                var g = data[pixelInfo+1]
                var b = data[pixelInfo+2]
                var a = data[pixelInfo+3]
                var sum: UInt32 = UInt32(r) + UInt32(g) + UInt32(b)
                sumRGB.append(UInt32(sum))
            }
        }
        sumRGB.sort{$0 < $1}
        var median: UInt32 = sumRGB[sumRGB.count / 2]
        var sumSumRGB: UInt32 = 0
        var ind: Int
        for(ind = 0; ind < sumRGB.count; ind++) {
            sumSumRGB += sumRGB[ind]
        }
        var average = UInt32(sumSumRGB / UInt32(sumRGB.count))
        for (x = 0; x < Int(srcImg.size.width); x++) {
            var y: Int = 0
            for (y = 0; y < Int(srcImg.size.height); y++) {
                var pixelInfo: Int = ((Int(srcImg.size.width) * Int(y)) + Int(x)) * 4
                var r = data[pixelInfo]
                var g = data[pixelInfo+1]
                var b = data[pixelInfo+2]
                var a = data[pixelInfo+3]
                var sum: UInt32 = UInt32(r) + UInt32(g) + UInt32(b)
                if (sum > average * 8 / 9) {
                    CGContextSetRGBFillColor(context, 0.97647 , 0.917647, 0.80392, 1);
                    CGContextFillRect(context, CGRectMake(CGFloat(x), srcImg.size.height - CGFloat(y), 1, 1));
                }
            }
        }
        CGContextRestoreGState(context)
        var tgtImg = UIGraphicsGetImageFromCurrentImageContext()
        var blurfilter = CIFilter(name: "CIGaussianBlur")
        var inputImg = CIImage(image: tgtImg)
        blurfilter.setValue(inputImg, forKey: "inputImage")
        blurfilter.setValue(1, forKey: "inputRadius")
        var resultImage = blurfilter.valueForKey("outputImage") as CIImage
        println("face bg color changed")
        return UIImage(CIImage: resultImage)
    }
    
}
