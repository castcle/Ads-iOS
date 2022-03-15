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
//  AdsPreviewViewController.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 23/2/2565 BE.
//

import UIKit
import Core
import Networking
import Component

class AdsPreviewViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var viewModel = AdsPreviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Asset.darkGraphiteBlue
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.customNavigationBar(.primary, title: "Ad Preview", leftBarButton: .back)
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerFeedCell()
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsBudget, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsBudget)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.confirmButton, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.confirmButton)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }
}

extension AdsPreviewViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.adsPreviewSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.adsPreviewSection[indexPath.row] == .confirm {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.confirmButton, for: indexPath as IndexPath) as? ConfirmButtonTableViewCell
            cell?.configCell(title: self.viewModel.ads.boostType == .page ? "Boost this Page" : "Boost this Cast")
            cell?.delegate = self
            cell?.backgroundColor = UIColor.clear
            return cell ?? ConfirmButtonTableViewCell()
        } else if self.viewModel.adsPreviewSection[indexPath.row] == .header {
            let cell = tableView.dequeueReusableCell(withIdentifier: ComponentNibVars.TableViewCell.headerFeed, for: indexPath as IndexPath) as? HeaderTableViewCell
            cell?.backgroundColor = UIColor.Asset.darkGray
            cell?.configAdsPreViewCell(page: self.viewModel.page)
            return cell ?? HeaderTableViewCell()
        } else if self.viewModel.adsPreviewSection[indexPath.row] == .page {
            let cell = tableView.dequeueReusableCell(withIdentifier: ComponentNibVars.TableViewCell.adsPage, for: indexPath as IndexPath) as? AdsPageTableViewCell
            cell?.backgroundColor = UIColor.Asset.darkGray
            cell?.configAdsPreViewCell(page: self.viewModel.page, ads: self.viewModel.ads)
            return cell ?? AdsPageTableViewCell()
        } else {
            return UITableViewCell()
        }
    }
}

extension AdsPreviewViewController: ConfirmButtonTableViewCellDelegate {
    func didConfirm(_ cell: ConfirmButtonTableViewCell) {
        //
    }
}
