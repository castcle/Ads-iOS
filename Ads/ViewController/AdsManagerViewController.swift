//  Copyright (c) 2021, Castcle and/or its affiliates. All rights reserved.
//  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
//
//  This code is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License version 3 only, as
//  published by the Free Software Foundation.
//
//  This code is distributed in the hope that it will be useful, but WITHOUT
//  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
//  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
//  version 3 for more details (a copy is included in the LICENSE file that
//  accompanied this code).
//
//  You should have received a copy of the GNU General Public License version
//  3 along with this work; if not, write to the Free Software Foundation,
//  Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
//
//  Please contact Castcle, 22 Phet Kasem 47/2 Alley, Bang Khae, Bangkok,
//  Thailand 10160, or visit www.castcle.com if you need additional information
//  or have any questions.
//
//  AdsManagerViewController.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 3/2/2565 BE.
//

import UIKit
import Core
import SwiftColor

class AdsManagerViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var boostButton: UIButton!
    
    enum AdsManagerViewControllerSection: Int, CaseIterable {
        case budget = 0
        case history
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Asset.darkGraphiteBlue
        self.configureTableView()
        self.boostButton.titleLabel?.font = UIFont.asset(.regular, fontSize: .h4)
        self.boostButton.setTitleColor(UIColor.Asset.white, for: .normal)
        self.boostButton.setBackgroundImage(UIColor.Asset.lightBlue.toImage(), for: .normal)
        self.boostButton.capsule(color: UIColor.clear, borderWidth: 1, borderColor: UIColor.clear)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.customNavigationBar(.primary, title: "Ad manager", leftBarButton: .back)
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsBudget, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsBudget)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsNoHistory, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsNoHistory)
//        self.tableView.register(UINib(nibName: SettingNibVars.TableViewCell.pageList, bundle: ConfigBundle.setting), forCellReuseIdentifier: SettingNibVars.TableViewCell.pageList)
//        self.tableView.register(UINib(nibName: SettingNibVars.TableViewCell.setting, bundle: ConfigBundle.setting), forCellReuseIdentifier: SettingNibVars.TableViewCell.setting)
//        self.tableView.register(UINib(nibName: SettingNibVars.TableViewCell.other, bundle: ConfigBundle.setting), forCellReuseIdentifier: SettingNibVars.TableViewCell.other)
//        self.tableView.register(UINib(nibName: SettingNibVars.TableViewCell.social, bundle: ConfigBundle.setting), forCellReuseIdentifier: SettingNibVars.TableViewCell.social)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }
    
    @IBAction func boostAction(_ sender: Any) {
    }
}

extension AdsManagerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return AdsManagerViewControllerSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case AdsManagerViewControllerSection.budget.rawValue:
            return 1
        case AdsManagerViewControllerSection.history.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == AdsManagerViewControllerSection.history.rawValue {
            return 15
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 15))
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 0, width: headerView.frame.width - 30, height: headerView.frame.height)
        label.font = UIFont.asset(.regular, fontSize: .body)
        label.textColor = UIColor.Asset.white

        switch section {
        case AdsManagerViewControllerSection.history.rawValue:
            label.text = "All boosts"
        default:
            label.text = ""
        }
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case AdsManagerViewControllerSection.budget.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsBudget, for: indexPath as IndexPath) as? AdsBudgetTableViewCell
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsBudgetTableViewCell()
        case AdsManagerViewControllerSection.history.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsNoHistory, for: indexPath as IndexPath) as? AdsNoHistoryTableViewCell
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsNoHistoryTableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
