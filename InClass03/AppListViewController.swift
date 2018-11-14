//
//  File Name. : AppListViewController.swift
//  Assignment : InClass03
//  Student Full Name : Pranalee Jadhav
//  Created by Pranalee Jadhav on 10/28/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class AppTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var releaseLb: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var appImg: UIImageView!
    
    @IBOutlet weak var imgTop: NSLayoutConstraint!
    @IBOutlet weak var imgHt: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    
    @IBOutlet weak var imgAspect: NSLayoutConstraint!
    
    
    
    
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
}

class AppListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let dateFormatter = DateFormatter()
    var tableArr = [Dictionary<String,Any>]()
    enum TableSection: Int {
        case games = 0, media, business, education, health, weather, entertainment, music, medical, total
    }
    // This is the size of our header sections that we will use later on.
    let SectionHeaderHeight: CGFloat = 50
    
    // Data variable to track our sorted data.
    var data = [TableSection: [[String: Any]]]()
    var cellSelected: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Apps"
        tableView.tableFooterView = UIView()
        getDataFromApi()
        
        
    }
    
    func getDataFromApi() {
        getData(onSuccess: {(result) in
            let resultArr = result as! Dictionary<String,Any>
            if (resultArr["feed"] != nil) {
                
                self.tableArr = (resultArr["feed"] as? [Dictionary<String,Any>])!
                self.sortData()
                self.tableView.reloadData()
            }
            
            
        }, onFail: {(error) in
            
        })
    }
    
    // When generating sorted table data we can easily use our TableSection to make look up simple and easy to read.
    func sortData() {
        
        data[.games] = tableArr.filter({ $0["category"] as? String == "Games" })
        data[.media] = tableArr.filter({ $0["category"] as? String == "Photo & Video" })
        data[.business] = tableArr.filter({ $0["category"] as? String == "Business" })
        data[.education] = tableArr.filter({ $0["category"] as? String == "Education" })
        data[.health] = tableArr.filter({ $0["category"] as? String == "Health & Fitness" })
        data[.weather] = tableArr.filter({ $0["category"] as? String == "Weather" })
        data[.entertainment] = tableArr.filter({ $0["category"] as? String == "Entertainment" })
        data[.music] = tableArr.filter({ $0["category"] as? String == "Music" })
        data[.medical] = tableArr.filter({ $0["category"] as? String == "Medical" })
        
    }
    // MARK: - TableView Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = TableSection(rawValue: section), let appData = data[tableSection] {
            return appData.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let tableSection = TableSection(rawValue: section), let appData = data[tableSection], appData.count > 0 {
            return SectionHeaderHeight
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem2") as!  AppTableViewCell  //1.
        
        if let tableSection = TableSection(rawValue: indexPath.section), let appData = data[tableSection]?[indexPath.row]{
            cell.appTitleLabel.text = appData["title"] as? String
            cell.appTitleLabel.adjustsFontSizeToFitWidth = true
            
            cell.developerLabel.text = appData["developer"] as? String
            cell.cost.text =  appData["price"] as? String
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-SS:SS"
            let date = dateFormatter.date(from: (appData["releaseDate"] as? String)!)! // "2017-01-27T18:36.326Z"
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let dateString = dateFormatter.string(from: date)
            cell.releaseLb.text = dateString
            cell.appImg.sd_setImage(with: URL(string: appData["squareIcon"]! as! String), placeholderImage: UIImage(named: "placeholder.png"))
            
            cell.imgView.isHidden = true
            cell.labelText.isHidden = true
            cell.imgTop.constant = 0
            cell.labelTop.constant = 0
            cell.imgHt.constant = 0
            
            if let image = appData["otherImage"] as? String {
                cell.imgView.isHidden = false
                cell.imgView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder.png"))
                cell.imgTop.constant = 7
                cell.labelTop.constant = 0
                cell.imgHt.constant = 200
                
            }
            if let text = appData["summary"] as? String {
                cell.labelText.isHidden = false
                cell.labelText.text = text
                cell.labelTop.constant = 7
                
            }
            
        }
        
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
                case .games: return "Games"
                case .media: return "Photo & Video"
                case .business: return "Business"
                case .education: return "Education"
                case .health: return "Health & Fitness"
                case .weather: return "Weather"
                case .entertainment: return "Entertainment"
                case .music: return "Music"
                case .medical: return "Medical"
                
                default: return ""
            }
        }
        return ""
    }
    
    func calculateHeight(inString:String) -> CGFloat
    {
        
        let rect : CGRect = inString.boundingRect(with: CGSize(width: 160, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var cellHt:CGFloat = 150
        if let tableSection = TableSection(rawValue: indexPath.section), let appData = data[tableSection]?[indexPath.row]{
            
            if let image = appData["otherImage"] as? String {
                cellHt += 200
            }
            
            if let text = appData["summary"] as? String {
                
                let heightOfRow = self.calculateHeight(inString: text) + 100

                cellHt += heightOfRow
                
            }
        }
        
        return CGFloat(cellHt);
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
   
   
    
}
