//
//  ViewController.swift
//  Cthulhu Mythos
//
//  Created by konojunya on 2016/10/26.
//  Copyright © 2016年 konojunya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var familyName: String? = nil
    private var nameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        
        if let familyName = familyName{
            nameArray = UIFont.fontNames(forFamilyName: familyName)
            title = familyName
        }else{
            nameArray = UIFont.familyNames
            title = "Font families"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "name_cell", for: indexPath) as! Cell
        let fontName = nameArray[indexPath.row]
        cell.nameLabel.text = fontName
        cell.nameLabel?.font = UIFont(name: fontName,size: 17.0)
        
        if familyName == nil && UIFont.fontNames(forFamilyName: fontName).count > 1 {
            cell.accessoryType = .disclosureIndicator
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath),
            cell.accessoryType == .disclosureIndicator,
            familyName == nil else {
                return
        }
        
        if let viewController = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "main") as? ViewController {
            viewController.familyName = nameArray[indexPath.row]
            if let navigator = navigationController{
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
}

