//
//  RocketDetailViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 15.09.2021.
//

import UIKit

class RocketDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private lazy var detailsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .customWhite
        //tableView.separatorColor = .customGray
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.isUserInteractionEnabled = true
        tableView.register(NewGameHeaderView.self, forHeaderFooterViewReuseIdentifier: "NewGameHeaderId")
        tableView.register(NewGameFooterView.self, forHeaderFooterViewReuseIdentifier: "NewGameFooterId")
        //tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: PlayerTableViewCell.cellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewGameCellId")
        //tableView.register(PlayersListFooterTableViewCell.self, forCellReuseIdentifier: "NewGameFooterCellId")
        tableView.layer.cornerRadius = 15
        tableView.isEditing = true
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.allowsSelection = true
        //tableView.tableHeaderView?.backgroundColor = .lightDark
        //tableView.tableFooterView = UIView()
        //tableView.maxHeight = 372
        //tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 1)))
        return tableView
        }()
    
    enum TableSection: Int {
      case description = 0, overview, images, engines, firstStage, secondStage, landingLegs, materials, total
    }
    
    let SectionHeaderHeight: CGFloat = 65
    
    var rocket: Rocket?
    
    let detailsDictionary: KeyValuePairs<Any, Any>

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public func configure(with rocketInstance: Rocket) {
        rocket = rocketInstance
        //carouselCollectionView.reloadData()
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
      return TableSection.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      if let tableSection = TableSection(rawValue: section), let rocketData = data[tableSection] {
        return rocketData.count
      }
        
      return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      // If we wanted to always show a section header regardless of whether or not there were rows in it,
      // then uncomment this line below:
      //return SectionHeaderHeight

      // First check if there is a valid section of table.
      // Then we check that for the section there is more than 1 row.
      if let tableSection = TableSection(rawValue: section), let movieData = data[tableSection], movieData.count > 0 {
        return SectionHeaderHeight
      }
      return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
      view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
      let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
      label.font = UIFont.boldSystemFont(ofSize: 15)
      label.textColor = UIColor.black
      if let tableSection = TableSection(rawValue: section) {
        switch tableSection {
        case .description:
            <#code#>
        case .overview:
            <#code#>
        case .images:
            <#code#>
        case .engines:
            <#code#>
        case .firstStage:
            <#code#>
        case .secondStage:
            <#code#>
        case .landingLegs:
            <#code#>
        case .materials:
            <#code#>
        case .total:
            <#code#>
        }
      view.addSubview(label)
      return view
    }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      // Similar to above, first check if there is a valid section of table.
      // Then we check that for the section there is a row.
      if let tableSection = TableSection(rawValue: indexPath.section), let movie = data[tableSection]?[indexPath.row] {
        if let titleLabel = cell.viewWithTag(10) as? UILabel {
          titleLabel.text = movie["title"]
        }
        if let subtitleLabel = cell.viewWithTag(20) as? UILabel {
          subtitleLabel.text = movie["cast"]
        }
      }
      return cell
    }
    

}

/*
 class RocketDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
     
     
     private lazy var detailsTableView: UITableView = {
         let tableView = UITableView(frame: .zero, style: .grouped)
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.backgroundColor = .customWhite
         //tableView.separatorColor = .customGray
         tableView.delegate = self
         tableView.dataSource = self
         //tableView.isUserInteractionEnabled = true
         tableView.register(NewGameHeaderView.self, forHeaderFooterViewReuseIdentifier: "NewGameHeaderId")
         tableView.register(NewGameFooterView.self, forHeaderFooterViewReuseIdentifier: "NewGameFooterId")
         //tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: PlayerTableViewCell.cellId)
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewGameCellId")
         //tableView.register(PlayersListFooterTableViewCell.self, forCellReuseIdentifier: "NewGameFooterCellId")
         tableView.layer.cornerRadius = 15
         tableView.isEditing = true
         tableView.allowsMultipleSelectionDuringEditing = false
         tableView.showsVerticalScrollIndicator = false
         tableView.contentInsetAdjustmentBehavior = .always
         tableView.allowsSelection = true
         //tableView.tableHeaderView?.backgroundColor = .lightDark
         //tableView.tableFooterView = UIView()
         //tableView.maxHeight = 372
         //tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 1)))
         return tableView
         }()
     
     enum TableSection: Int {
       case description = 0, overview, images, engines, firstStage, secondStage, landingLegs, materials, total
     }
     
     let SectionHeaderHeight: CGFloat = 65
     
     var rocket: Rocket?
     
     let detailsDictionary: KeyValuePairs<Any, Any>

     override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
     }
     
     public func configure(with rocketInstance: Rocket) {
         rocket = rocketInstance
         //carouselCollectionView.reloadData()
     }
     

     func numberOfSections(in tableView: UITableView) -> Int {
       return TableSection.total.rawValue
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       if let tableSection = TableSection(rawValue: section), let rocketData = data[tableSection] {
         return rocketData.count
       }
         
       return 0
     }
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       // If we wanted to always show a section header regardless of whether or not there were rows in it,
       // then uncomment this line below:
       //return SectionHeaderHeight

       // First check if there is a valid section of table.
       // Then we check that for the section there is more than 1 row.
       if let tableSection = TableSection(rawValue: section), let movieData = data[tableSection], movieData.count > 0 {
         return SectionHeaderHeight
       }
       return 0
     }
     
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
       view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
       let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
       label.font = UIFont.boldSystemFont(ofSize: 15)
       label.textColor = UIColor.black
       if let tableSection = TableSection(rawValue: section) {
         switch tableSection {
         case .description:
             <#code#>
         case .overview:
             <#code#>
         case .images:
             <#code#>
         case .engines:
             <#code#>
         case .firstStage:
             <#code#>
         case .secondStage:
             <#code#>
         case .landingLegs:
             <#code#>
         case .materials:
             <#code#>
         case .total:
             <#code#>
         }
       view.addSubview(label)
       return view
     }
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       // Similar to above, first check if there is a valid section of table.
       // Then we check that for the section there is a row.
       if let tableSection = TableSection(rawValue: indexPath.section), let movie = data[tableSection]?[indexPath.row] {
         if let titleLabel = cell.viewWithTag(10) as? UILabel {
           titleLabel.text = movie["title"]
         }
         if let subtitleLabel = cell.viewWithTag(20) as? UILabel {
           subtitleLabel.text = movie["cast"]
         }
       }
       return cell
     }
     

 }

 */
