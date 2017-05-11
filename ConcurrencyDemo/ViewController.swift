//
//  ViewController.swift
//  ConcurrencyDemo
//
//  Created by Hossam Ghareeb on 11/15/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

import UIKit

let imageURLs = ["http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg", "http://cdn.kul.vn/data/article/2016/04/23/ho-nay-cua-viet-nam-nhieu-thu-4-tren-khap-the-gioi-1_1461382417.jpg", "http://baonga.com/FileUpload/Images/050712_011146photo6.jpg", "http://a8.vietbao.vn/images/vn888/hot/v2012/best_20121105-131712-3-Redsvn-Asian-Trip-03.jpeg"]

class Downloader {
    
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
}

class ViewController: UIViewController {
    public enum NSOperationQueuePriority : Int {
        case VeryLow
        case Low
        case Normal
        case High
        case VeryHigh
    }

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    var queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Using Concurrent Dispatch Queues
    
    /*@IBAction func didClickOnStart(_ sender: AnyObject) {
        
        let queue = DispatchQueue.global(qos: .default)
        queue.async() { () -> Void in
            
    
            let img1 = Downloader.downloadImageWithURL(imageURLs[0])
            DispatchQueue.main.async(execute: {
                
                self.imageView1.image = img1
            })
            
        }
        queue.async() { () -> Void in
            
            let img2 = Downloader.downloadImageWithURL(imageURLs[1])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView2.image = img2
            })
            
        }
        queue.async() { () -> Void in
            
            let img3 = Downloader.downloadImageWithURL(imageURLs[2])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView3.image = img3
            })
            
        }
        queue.async() { () -> Void in
            
            let img4 = Downloader.downloadImageWithURL(imageURLs[3])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView4.image = img4
            })
        }
    }*/
    
    //Using Serial Dispatch Queues
    
    /*@IBAction func didClickOnStart(sender: AnyObject) {
        
        let serialQueue = DispatchQueue(label: "com.appcoda.imagesQueue")
        
        
        serialQueue.async() { () -> Void in
            
            let img1 = Downloader .downloadImageWithURL(imageURLs[0])
            DispatchQueue.main.async(execute: {
                
                self.imageView1.image = img1
            })
            
        }
        serialQueue.async() { () -> Void in
            
            let img2 = Downloader.downloadImageWithURL(imageURLs[1])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView2.image = img2
            })
            
        }
        serialQueue.async() { () -> Void in
            
            let img3 = Downloader.downloadImageWithURL(imageURLs[2])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView3.image = img3
            })
            
        }
        serialQueue.async() { () -> Void in
            
            let img4 = Downloader.downloadImageWithURL(imageURLs[3])
            
            DispatchQueue.main.async(execute: {
                
                self.imageView4.image = img4
            })
        }
        */
    //}
    
    
    //NSOperationQueue
    
    @IBAction func didClickOnStart(sender: AnyObject) {
        queue = OperationQueue()
        let operation1 = BlockOperation(block: {
            let img1 = Downloader.downloadImageWithURL(imageURLs[0])
            OperationQueue.main.addOperation({
                self.imageView1.image = img1
            })
        })
        
        operation1.completionBlock = {
            operation1.completionBlock = {
                print("Operation 1 completed, cancelled:\(operation1.isCancelled) ")
            }
        }
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {
            let img2 = Downloader.downloadImageWithURL(imageURLs[1])
            OperationQueue.main.addOperation({
                self.imageView2.image = img2
            })
        })
        
        operation2.completionBlock = {
            print("Operation 2 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation2)
        
        
        let operation3 = BlockOperation(block: {
            let img3 = Downloader.downloadImageWithURL(imageURLs[2])
            OperationQueue.main.addOperation({
                self.imageView3.image = img3
            })
        })
        
        operation3.completionBlock = {
            print("Operation 3 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation3)
        
        let operation4 = BlockOperation(block: {
            let img4 = Downloader.downloadImageWithURL(imageURLs[3])
            OperationQueue.main.addOperation({
                self.imageView4.image = img4
            })
        })
        
        operation4.completionBlock = {
            print("Operation 4 completed, cancelled:\(operation1.isCancelled) ")
        }
        queue.addOperation(operation4)
        
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)
    }
    
    @IBAction func didClickOnCancel(sender: AnyObject) {
        
        self.queue.cancelAllOperations()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        self.sliderValueLabel.text = "\(sender.value * 100.0)"
    }

}

