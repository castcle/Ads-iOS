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
//  SelectDailyBidTypeViewController.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 13/6/2565 BE.
//

import UIKit
import Core
import Networking

protocol SelectDailyBidTypeViewControllerDelegate: AnyObject {
    func didDailyBidType(_ view: SelectDailyBidTypeViewController, dailyBidType: DailyBidType, cost: Int)
}

class SelectDailyBidTypeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var delegate: SelectDailyBidTypeViewControllerDelegate?
    let dailyBidTypes: [DailyBidType] = [.auto, .costPerAccount]
    var oldSelect: DailyBidType = .auto
    var cost: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Asset.darkGraphiteBlue
        self.configureTableView()
        self.hideKeyboardWhenTapped()
        self.setupNavBar()
    }

    func setupNavBar() {
        self.customNavigationBar(.primary, title: "Daily Bid", leftBarButton: .back)
    }

    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.dailyBidCostPerAccount, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.dailyBidCostPerAccount)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.dailyBidAuto, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.dailyBidAuto)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }
}

extension SelectDailyBidTypeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dailyBidTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dailyBidTypes[indexPath.row] == .costPerAccount {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.dailyBidCostPerAccount, for: indexPath as IndexPath) as? DailyBidCostPerAccountTableViewCell
            cell?.backgroundColor = UIColor.Asset.cellBackground
            cell?.delegate = self
            cell?.configCell(dailyBidType: self.dailyBidTypes[indexPath.row], oldSelect: self.oldSelect, cost: self.cost)
            return cell ?? DailyBidCostPerAccountTableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.dailyBidAuto, for: indexPath as IndexPath) as? DailyBidAutoTableViewCell
            cell?.backgroundColor = UIColor.Asset.cellBackground
            cell?.configCell(dailyBidType: self.dailyBidTypes[indexPath.row], oldSelect: self.oldSelect)
            return cell ?? DailyBidAutoTableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didDailyBidType(self, dailyBidType: self.dailyBidTypes[indexPath.row], cost: self.cost)
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelectDailyBidTypeViewController: DailyBidCostPerAccountTableViewCellDelegate {
    func didCostChange(_ dailyBidCostPerAccountTableViewCell: DailyBidCostPerAccountTableViewCell, cost: Int) {
        self.cost = cost
    }
}
