//
//  ViewController.swift
//  CoreMLDemo
//
//  Created by 柳玉豹 on 2018/3/20.
//  Copyright © 2018年 xinghaiwulian. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var indiccator: UIActivityIndicatorView!
    
    
    @IBAction func btnClicked(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    //协议实现方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imgV.image = image
            analysisImageWithoutVision(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func showAnalysisResultOnMainQueue(with message: String) {
        //回到主线程上
        DispatchQueue.main.async {
            //创建alert
            let alert = UIAlertController(title: "Completed", message: message, preferredStyle: .alert)
            let cancelAct = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAct)
            self.present(alert, animated: true) {
                //点击取消后允许用户操作
                self.indiccator.stopAnimating()
                self.view.isUserInteractionEnabled = true
             }
         }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    func CreatePixelBufferFromImage(_ image: UIImage) -> CVPixelBuffer?{
        let size = image.size
        var pxbuffer : CVPixelBuffer?
        let pixelBufferPool = createPixelBufferPool(Int32(size.width), Int32(size.height), FourCharCode(kCVPixelFormatType_32BGRA), 2056)
        let status = CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pixelBufferPool!, &pxbuffer)
        guard (status == kCVReturnSuccess) else{
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pxdata = CVPixelBufferGetBaseAddress(pxbuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pxdata,width: Int(size.width),height: Int(size.height),bitsPerComponent: 8,bytesPerRow: CVPixelBufferGetBytesPerRow(pxbuffer!),space: rgbColorSpace,bitmapInfo:CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0))
        return pxbuffer
        
  }
    
  func createPixelBufferPool(_ width: Int32, _ height: Int32, _ pixelFormat: FourCharCode, _ maxBufferCount: Int32) -> CVPixelBufferPool? {
        var outputPool: CVPixelBufferPool? = nil
        let sourcePixelBufferOptions: NSDictionary = [kCVPixelBufferPixelFormatTypeKey: pixelFormat,kCVPixelBufferWidthKey: width,kCVPixelBufferHeightKey: height,kCVPixelFormatOpenGLESCompatibility: true,kCVPixelBufferIOSurfacePropertiesKey: NSDictionary()]
        let pixelBufferPoolOptions: NSDictionary = [kCVPixelBufferPoolMinimumBufferCountKey: maxBufferCount]
        CVPixelBufferPoolCreate(kCFAllocatorDefault, pixelBufferPoolOptions,sourcePixelBufferOptions, &outputPool)
        return outputPool
       }
    
}


extension ViewController {
    //只使用CoreML方法来分析
    func analysisImageWithoutVision(image: UIImage) {
        indiccator.startAnimating()
        view.isUserInteractionEnabled = false
        
        //---------------- 1--------------------
        DispatchQueue.global(qos: .userInteractive).async {
            //---------------- 2----------------
            let imageWidth:CGFloat = 224.0
            let imageHeight:CGFloat = 224.0
            UIGraphicsBeginImageContext(CGSize(width:imageWidth, height:imageHeight))
            image.draw(in:CGRect(x:0, y:0, width:imageHeight, height:imageHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            guard let newImage = resizedImage else {
                fatalError("resized Image fail")
        }
            
        //---------------- 3----------------
        guard let pixelBuffer = self.CreatePixelBufferFromImage(newImage) else {
            fatalError("convert PixelBuffer fail")
        }
            
        // ----------------4----------------
        guard let output = try? GoogLeNetPlaces().prediction(sceneImage: pixelBuffer) else {
            fatalError("predict fail")
        }
            
        // ----------------5----------------
        let result = "\(output.sceneLabel)(\(Int(output.sceneLabelProbs[output.sceneLabel]! * 100))%)"
            
        // ----------------6----------------
        self.showAnalysisResultOnMainQueue(with: result)
            
        }
        
    }
    //使用CoreML+Vision方法来分析
    func analysisImageWithVision(image: UIImage) {
        indiccator.startAnimating()
        view.isUserInteractionEnabled = false
        
        //转换图片类型
        guard let ciImage = CIImage(image: image) else {
            fatalError("convert CIImage error")
        }
        
    }
    
}

