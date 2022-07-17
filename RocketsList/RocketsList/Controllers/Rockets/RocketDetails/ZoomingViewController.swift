//
//  ZoomingViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 16.09.2021.
//

import UIKit

class ZoomingViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let photoImageView: ImageLoader = {
        let imageView = ImageLoader()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor.clear
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite
        setupViews()
    }
     
     init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.photoImageView.image = image
    }
    
    init(url: URL) {
       super.init(nibName: nil, bundle: nil)
        self.photoImageView.loadImageWithUrl(url)
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        centerImage()
    }
    
    func setupViews() {
        scrollView.delegate = self
        scrollView.contentSize = photoImageView.bounds.size
        setCurrentMaxandMinZoomScale()
        centerImage()
        scrollView.zoomScale = scrollView.minimumZoomScale
        scrollView.clipsToBounds = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(photoImageView)
        view.addSubview(closeButton)
        
        setupButtonHiding()
        
        NSLayoutConstraint.activate([
           scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
           scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
           scrollView.frameLayoutGuide.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
           scrollView.frameLayoutGuide.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
           scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
           scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
           scrollView.contentLayoutGuide.leftAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leftAnchor),
           scrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25.0)
        ])
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            photoImageView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor)
        ])
    }
    
    public func setupPhoto(image: UIImage) {
        self.photoImageView.image = image
    }
    
    func setCurrentMaxandMinZoomScale() {
        let boundsSize = view.bounds.size
        let imageSize = view.bounds.size
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        let maxScale: CGFloat = 3.0
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maxScale
    }
    
    func centerImage() {
        let boundsSize = scrollView.bounds.size
        var frameToCenter = photoImageView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        photoImageView.frame = frameToCenter
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoImageView
    }
    
    @objc func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupButtonHiding() {
        scrollView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideButton))
        tapGesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideButton() {
        closeButton.isHidden = !(closeButton.isHidden)
        view.backgroundColor = view.backgroundColor == .customWhite ? .smokyBlack : .customWhite
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

