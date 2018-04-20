//
//  SettingCell.swift
//  BiometricAuth
//
//  Created by Luigi Aiello on 18/04/18.
//  Copyright © 2018 Luigi Aiello. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switcher: UISwitch!

    //MARK:- Handlers
    var switcherHandler: SwitcherChanged?

    //MARK:- Override
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK:- Setup
    func setup(title: String?, status: Bool?, handler: SwitcherChanged?) {
        titleLabel.text = title
        switcher.isOn = status ?? false
        switcherHandler = handler
    }
    
    //MARK:- Helpers
    private func reset() {
        titleLabel.text = nil
        switcherHandler = nil
    }
    
    //MARK:- Actions
    
    @IBAction func valueDidChanged(_ sender: Any) {
        switcherHandler?(switcher.isOn)
    }
}
