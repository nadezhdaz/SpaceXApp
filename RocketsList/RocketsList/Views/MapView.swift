//
//  MapView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 22.10.2021.
//

import UIKit
import MapKit

class MapView: ShadowView {

    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.isUserInteractionEnabled = false
        map.layer.cornerRadius = 15
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private var sizeConstraint = UIScreen.main.bounds.width - 40.0
    
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        //setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    init(name: String, latitude: Double, longitude: Double) {
        super.init(frame: .zero)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = name
        mapView.addAnnotation(annotation)
        mapView.setRegion(MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000), animated: false)
        
        setupUI()
    }
    
    private func setupUI(){
        backgroundColor = .customWhite
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
        layer.cornerRadius = 15
        
        addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: sizeConstraint),
            widthAnchor.constraint(equalToConstant: sizeConstraint)
        ])
    }

}
