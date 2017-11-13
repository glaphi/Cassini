//
//  ImageViewController.swift
//  Cassini
//
//  Created by Glaphi on 30/10/2017.
//  Copyright © 2017 glaphi. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    // MARK: Model
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil { // if view is already on screen
            fetchImage()            // fetch the image
            }
        }
    }
    
    // MARK: Private Implementations
    fileprivate var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue // setting image
            imageView.sizeToFit()      // resizing
            // if the scrollView outlet has not yet been set do nothing
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            // the next line of code can throw an error
            // it is in a separate thread
            // so it doesn't block the UI while accessing the network
            // self is an optional inside of the closure,
            // so imageVC can leave the heap after the user hits back button
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                // the closure captured the url, we are cheching
                // if that url is the one we are currently interested in
                if let imageData = urlContents, url == self?.imageURL {
                    // asyncronuosly! 
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    // MARK: User Interface
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            // to zoom we have to handle viewForZooming(in scrollView:)
            scrollView.delegate = self
            // and we must set our minimum and maximum zoom scale
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
            // most important thing to set in UIScrollView is contentSize
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    
//    // View Controller Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // view.addSubview(imageView) // add imageView to the top level view - named "view"
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage() 
        }
    }
}

// MARK: UIScrollViewDelegate
// Extension which makes ImageViewController conform to UIScrollViewDelegate
// Handles viewForZooming(in scrollView:)
// by returning the UIImageView as the view to transform when zooming
extension ImageViewController : UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */






