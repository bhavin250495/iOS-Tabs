//
//  TabVC.swift
//  TabsTutorial
//
//  Created by Jayesh Sharma on 04/08/18.
//  Copyright © 2018 HobbyDev. All rights reserved.
//

import UIKit

class TabVC: UIViewController {
    @IBOutlet weak var tableVC: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableVC.delegate = self
        tableVC.dataSource = self
        tableVC.tableFooterView = UIView.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

   
}
extension TabVC:UITableViewDelegate,
UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
        cell.textLabel?.text = "My index row is \(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    
}
