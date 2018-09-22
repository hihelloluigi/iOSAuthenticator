//
//  LoggedInVC.swift
//  BiometricAuth
//
//  Created by Luigi Aiello on 18/04/18.
//  Copyright © 2018 Luigi Aiello. All rights reserved.
//

import UIKit
import iOSAuthenticator

typealias SwitcherChanged = (_ status: Bool) -> Void

class LoggedInVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var successImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var rows = [(text: String, switchStatus: Bool?, handler: SwitcherChanged?)]()
    
    //MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Setup
    private func setup() {
        
        rows = []
        
        var component: String = ""
        switch iOSAuthenticator.biometricType() {
        case .touchID:
            component = "Touch ID"
        case .faceID:
            component = "Face ID"
        case .notAvailable:
            print("Not available")
        }
        
        rows.append(("Usa \(component) per sbloccare l'app", Config.biometric(), { (status) in
            let _ = Config.store(biometric: status)
            if !status {
                let _ = Config.store(wakeUpBiometric: status)
                let _ = Config.store(coverMultitasking: status)
            }
            self.setup()
            self.tableView.reloadData()
        }))
        
        if Config.biometric() ?? false {
            rows.append(("Richiedi al risveglio dell'app dal background", Config.wakeUpBiometric(), { (status) in
                let _ = Config.store(wakeUpBiometric: status)
            }))
            rows.append(("Copri la schermata quando l'app è in multitasking", Config.coverMultitasking(), { (status) in
                let _ = Config.store(coverMultitasking: status)
            }))
        }
    }
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = true
        tableView.dataSource = self
    }
}

//MARK:- Table View Data Source
extension LoggedInVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            indexPath.row < rows.count,
            let cell = tableView.dequeueReusableCell(withIdentifier: "setting cell", for: indexPath) as? SettingCell
        else {
            return UITableViewCell()
        }
        
        let row = rows[indexPath.row]
        cell.setup(title: row.text, status: row.switchStatus, handler: row.handler)
        
        return cell
    }
}
