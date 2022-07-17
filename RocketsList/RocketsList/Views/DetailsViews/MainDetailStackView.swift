//
//  MainDetailStackView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 15.09.2021.
//

import UIKit

protocol MainDetailStackViewDelegate {
    func presentZoomingController(url: URL)
}

protocol RocketGetterDelegate {
    func getRocketWithID(_ id: String) -> Rocket
}

class MainDetailStackView: UIStackView, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Properties

    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 24.0) ?? .systemFont(ofSize: 24.0)
        label.textColor = .smokyBlack
        label.text = label.text?.capitalized
        label.textAlignment = .left
        let heightConstraint = label.heightAnchor.constraint(equalToConstant: 40.0)
        heightConstraint.isActive = true
        return label
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Medium", size: 14.0) ?? .systemFont(ofSize: 14.0)
        label.textColor = .smokyBlack
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var imagesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = UIScreen.main.bounds.width * 0.36
        let height = width * 1.35
        viewLayout.itemSize = CGSize(width: 145.0, height: 196.0)
        viewLayout.minimumInteritemSpacing = 0
        viewLayout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(cellType: ImageCollectionViewCell.self, nib: false)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        let collectionWidth = UIScreen.main.bounds.width - 30.0
        let heightConstraint = collection.heightAnchor.constraint(equalToConstant: 200.0)
        heightConstraint.isActive = true
        let widthConstraint = collection.widthAnchor.constraint(equalToConstant: collectionWidth)
        widthConstraint.isActive = true
        return collection
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public enum RocketType: String {
      case description = "Description", overview = "Overview", images = "Images", engines = "Engines", firstStage = "First Stage", secondStage = "Second Stage", landingLegs = "Landing Legs", materials = "Materials"
    }
    
    public enum LaunchType: String {
        case /*launchCell = "",*/ description = "Description", overview = "Overview", images = "Images", rocketCell = "Rocket", materials = "Materials", reddit = "Reddit"
    }
    
    public enum LaunchpadType: String {
        case /*launchpadCell = "",*/ description = "Description", overview = "Overview", images = "Images", location = "Location", materials = "Materials"
    }
    
    public enum SpaceXObjectType {
      case rocket, launch, launchpad
    }
    
    private var rocketType: RocketType?
    private var launchType: LaunchType?
    private var launchpadType: LaunchpadType?
    private var rocket: Rocket?
    private var launch: Launch?
    private var launchpad: Launchpad?
    private var rocketImageURLs: [URL]?
    
    public var webDelegate: WebButtonsViewDelegate?
    public var appDelegate: AppButtonsViewDelegate?
    public var zoomingDelegate: MainDetailStackViewDelegate?
    
    
    // MARK: - Initializers
    
    init(_ info: RocketType, rocket: Rocket) {
        super.init(frame: .zero)
        self.rocketType = info
        self.rocket = rocket
        setupUI()
        setupRocket(type: info, rocket)
    }
    
    init(_ info: LaunchType, launch: Launch, rocket: Rocket) {
        super.init(frame: .zero)
        self.launchType = info
        self.launch = launch
        self.rocket = rocket
        setupUI()
        setupLaunch(type: info, launch)
    }
    
    init(_ info: LaunchpadType, launchpad: Launchpad) {
        super.init(frame: .zero)
        self.launchpadType = info
        self.launchpad = launchpad
        //self.rocket = rocket
        setupUI()
        setupLaunchpad(type: info, launchpad)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups

    private func setupUI() {
        backgroundColor = .clear
        axis = .vertical
        distribution = .fillProportionally
        alignment = .leading
        spacing = 5
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupTitle(_ title: String) {
        titleLabel.text = title
        addArrangedSubview(titleLabel)
    }
    
    private func setupRocket(type: RocketType, _ rocket: Rocket?) {
        switch type {
        case .description:
            guard let rocketDescription = rocket?.rocketDescription else { return }
            setupTitle(type.rawValue)
            setupDescription(rocketDescription)
        case .overview:
            guard let rocketOverview = rocket else { return }
            setupTitle(type.rawValue)
            setupTable(for: rocketOverview)
        case .images:
            guard let rocketImages = rocket?.flickrImages else { return }
            setupTitle(type.rawValue)
            setupImagesCollection(urls: rocketImages)
        case .engines:
            guard let engines = rocket?.engines else { return }
            setupTitle(type.rawValue)
            setupTable(for: engines)
        case .firstStage:
            guard let firstStage = rocket?.firstStage else { return }
            setupTitle(type.rawValue)
            setupTable(for: firstStage)
        case .secondStage:
            guard let secondStage = rocket?.secondStage else { return }
            setupTitle(type.rawValue)
            setupTable(for: secondStage)
        case .landingLegs:
            guard let landingLegs = rocket?.landingLegs else { return }
            setupTitle(type.rawValue)
            setupTable(for: landingLegs)
        case .materials:
            guard let wikipedia = rocket?.wikipedia else { return }
            setupTitle(type.rawValue)
            setupWikipedia(wikipedia)
        }
    }
    
    private func setupLaunch(type: LaunchType, _ launch: Launch?) {
        switch type {
        case .description:
            guard let launchDescription = launch?.description else { return }
            setupTitle(type.rawValue)
            setupDescription(launchDescription)
        case .overview:
            guard let launchOverview = launch else { return }
            setupTitle(type.rawValue)
            setupTable(for: launchOverview)
        case .images:
            guard let rocketImages = launch?.links?.flickr?.original, !(rocketImages.isEmpty) else { return }
            setupTitle(type.rawValue)
            setupImagesCollection(urls: rocketImages)
        case .rocketCell:
            guard let rocket = rocket else { return }
            setupTitle(type.rawValue)
            setupRocketView(rocket: rocket)
        case .materials:
            guard let materials = launch?.links else { return }
            if materials.hasAnyValues() {
                setupTitle(type.rawValue)
                setupMaterials(materials)
            }
        case .reddit:
            guard let reddit = launch?.links?.reddit else { return }
            if reddit.hasAnyValues() {
                setupTitle(type.rawValue)
                setupReddit(reddit)
            }
        }
    }
    
    private func setupLaunchpad(type: LaunchpadType, _ launchpad: Launchpad?) {
        switch type {
        case .description:
            guard let launchpadDescription = launchpad?.description else { return }
            setupTitle(type.rawValue)
            setupDescription(launchpadDescription)
        case .overview:
            guard let launchpadOverview = launchpad else { return }
            setupTitle(type.rawValue)
            setupTable(for: launchpadOverview)
        case .images:
            guard let launchpadImages = launchpad?.images?.large else { return }
            setupTitle(type.rawValue)
            setupImagesCollection(urls: launchpadImages)
        case .location:
            guard let name = launchpad?.fullName else { return }
            guard let latitude = launchpad?.latitude else { return }
            guard let longitude = launchpad?.longitude else { return }
            setupTitle(type.rawValue)
            setupLocation(name: name, latitude: latitude, longitude: longitude)
        case .materials:
            setupTitle(type.rawValue)
            setupLaunchpadMaterials(rockets: launchpad?.rockets, launches: launchpad?.launches)
        }
    }
    
    public func setupDescription(_ description: String?) {
        descriptionLabel.text = description
        addArrangedSubview(descriptionLabel)
    }
    
    public func setupTable(for overview: Rocket) {
        if let firstLaunch = overview.firstLaunch {
            let stackRow = DetailStackView(title: "First launch", info: "\(firstLaunch)")
            addArrangedSubview(stackRow)
        }
        if let costPerLaunch = overview.costPerLaunch {
            let stackRow = DetailStackView(title: "Launch cost", info: "\(costPerLaunch)$")
            addArrangedSubview(stackRow)
        }
        if let successRatePct = overview.successRatePct {
            let stackRow = DetailStackView(title: "Success", info: "\(successRatePct)%")
            addArrangedSubview(stackRow)
        }
        if let mass = overview.mass?.kg {
            let stackRow = DetailStackView(title: "Mass", info: "\(mass) kg")
            addArrangedSubview(stackRow)
        }
        if let height = overview.height?.meters {
            let stackRow = DetailStackView(title: "Height", info: "\(height) meters")
            addArrangedSubview(stackRow)
        }
        if let diameter = overview.diameter?.meters {
            let stackRow = DetailStackView(title: "Diameter", info: "\(diameter) meters")
            addArrangedSubview(stackRow)
        }
    }
    
    public func setupTable(for overview: Launch) {
        if let staticFireDate = overview.staticFireDateUTC {
            let stackRow = DetailStackView(title: "Static Fire Date", info: "\(staticFireDate.utcTime())")
            addArrangedSubview(stackRow)
        }
        if let launchDate = overview.launchDateUTC {
            let stackRow = DetailStackView(title: "Launch date", info: "\(launchDate.utcTime())")
            addArrangedSubview(stackRow)
        }
        if let launchSuccess = overview.launchSuccess {
            let stackRow = DetailStackView(title: "Success", info: launchSuccess ? "Yes" : "No")
            addArrangedSubview(stackRow)
        }
    }
    
    public func setupTable(for engines: Engines) {
        if let type = engines.type {
            let stackRow = DetailStackView(title: "Type", info: "\(type)")
            addArrangedSubview(stackRow)
        }
        if let layout = engines.layout {
            let stackRow = DetailStackView(title: "Layout", info: "\(layout)")
            addArrangedSubview(stackRow)
        }
        if let version = engines.version {
            let stackRow = DetailStackView(title: "Version", info: "\(version)")
            addArrangedSubview(stackRow)
        }
        if let amount = engines.amount {
            let stackRow = DetailStackView(title: "Amount", info: "\(amount)")
            addArrangedSubview(stackRow)
        }
        if let propellant2 = engines.propellant1 {
            let stackRow = DetailStackView(title: "Propellant 1", info: "\(propellant2)")
            addArrangedSubview(stackRow)
        }
        if let propellant2 = engines.propellant2 {
            let stackRow = DetailStackView(title: "Propellant 2", info: "\(propellant2)")
            addArrangedSubview(stackRow)
        }
    }
    
    public func setupTable(for stage: FirstStage) {
        if let reusable = stage.reusable {
            let stackRow = DetailStackView(title: "Reusable", info: reusable ? "Yes" : "No")
            addArrangedSubview(stackRow)
        }
        if let enginesAmount = stage.enginesAmount {
            let stackRow = DetailStackView(title: "Engines amount", info: "\(enginesAmount)")
            addArrangedSubview(stackRow)
        }
        if let fuelAmountTons = stage.fuelAmountTons {
            let stackRow = DetailStackView(title: "Fuel amount", info: "\(Int(fuelAmountTons)) tons")
            addArrangedSubview(stackRow)
        }
        if let burningTime = stage.burningTime {
            let stackRow = DetailStackView(title: "Burning time", info: "\(burningTime) seconds")
            addArrangedSubview(stackRow)
        }
        if let thrustSeaLevel = stage.thrustSeaLevel?.kN {
            let stackRow = DetailStackView(title: "Thrust (sea level)", info: "\(thrustSeaLevel) kN")
            addArrangedSubview(stackRow)
        }
        if let thrustVacuum = stage.thrustVacuum?.kN {
            let stackRow = DetailStackView(title: "Thrust (vacuum)", info: "\(thrustVacuum) kN")
            addArrangedSubview(stackRow)
        }
    }
    
    public func setupTable(for stage: SecondStage) {
        if let reusable = stage.reusable {
            let stackRow = DetailStackView(title: "Reusable", info: reusable ? "Yes" : "No")
            addArrangedSubview(stackRow)
        }
        if let enginesAmount = stage.enginesAmount {
            let stackRow = DetailStackView(title: "Engines amount", info: "\(enginesAmount)")
            addArrangedSubview(stackRow)
        }
        if let fuelAmountTons = stage.fuelAmountTons {
            let stackRow = DetailStackView(title: "Fuel amount", info: "\(Int(fuelAmountTons)) tons")
            addArrangedSubview(stackRow)
        }
        if let burningTime = stage.burningTime {
            let stackRow = DetailStackView(title: "Burning time", info: "\(burningTime) seconds")
            addArrangedSubview(stackRow)
        }
        if let thrust = stage.thrust?.kN {
            let stackRow = DetailStackView(title: "Thrust", info: "\(thrust) kN")
            addArrangedSubview(stackRow)
        }
    }
    
    public func setupTable(for landingLegs: LandingLegs) {
        if let amount = landingLegs.number {
            let stackRow = DetailStackView(title: "Amount", info: "\(amount)")
            addArrangedSubview(stackRow)
        }
        if let material = landingLegs.material {
            let stackRow = DetailStackView(title: "Material", info: "\(material)")
            addArrangedSubview(stackRow)
        }
    }
    
    public func setupTable(for overview: Launchpad) {
        if let region = overview.region {
            let stackRow = DetailStackView(title: "Region", info: "\(region)")
            addArrangedSubview(stackRow)
        }
        if let locality = overview.locality {
            let stackRow = DetailStackView(title: "Location", info: "\(locality)")
            addArrangedSubview(stackRow)
        }
        if let launchAttempts = overview.launchAttempts {
            let stackRow = DetailStackView(title: "Launch attempts", info: "\(launchAttempts)")
            addArrangedSubview(stackRow)
        }
        if let launchSuccesses = overview.launchSuccesses {
            let stackRow = DetailStackView(title: "Launch success", info: "\(launchSuccesses)")
            addArrangedSubview(stackRow)
        }
    }
    
    public func setupImagesCollection(urls: [URL]) {
        imagesCollectionView.reloadData()
        rocketImageURLs = urls
        imagesCollectionView.reloadData()
        
        //imagesCollectionView.collectionViewLayout.invalidateLayout()
        addArrangedSubview(imagesCollectionView)
       
        
        
    }
    
    public func setupWikipedia(_ wikipedia: URL) {
        let buttonsRow = ButtonsView(wikipedia: wikipedia)
        buttonsRow.webDelegate = webDelegate
        addArrangedSubview(buttonsRow)
    }
    
    public func setupMaterials(_ materials: Links) {
        let buttonsRow = ButtonsView(link: materials)
        buttonsRow.webDelegate = webDelegate
        addArrangedSubview(buttonsRow)
    }
    
    public func setupLaunchpadMaterials(rockets: [String]?, launches: [String]?) {
        let buttonsRow = ButtonsView(rockets: rockets, launches: launches)
        buttonsRow.appDelegate = appDelegate
        addArrangedSubview(buttonsRow)
    }
    
    public func setupRocketView(rocket: Rocket) {
        let rocketView = RocketView().loadNib()
        rocketView.configure(rocket)
        addArrangedSubview(rocketView)
    }
    
    public func setupReddit(_ reddit: Reddit) {
        let buttonsRow = ButtonsView(reddit: reddit)
        buttonsRow.webDelegate = webDelegate
        addArrangedSubview(buttonsRow)
    }
    
    public func setupLocation(name: String, latitude: Double, longitude: Double) {
        let stackRow = MapView(name: name, latitude: latitude, longitude: longitude)
        addArrangedSubview(stackRow)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = rocketImageURLs else { return 0 }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let urls = rocketImageURLs else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueCell(of: ImageCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell() }
        let url = urls[indexPath.row]
        cell.configureImageFrom(url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = rocketImageURLs?[indexPath.row] else { return }
        guard let delegate = zoomingDelegate else { return }
        
        delegate.presentZoomingController(url: url)
    }
}

