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
//  SelectAdsObjectiveViewController.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 23/2/2565 BE.
//

import UIKit
import Core
import Networking

protocol SelectAdsObjectiveViewControllerDelegate: AnyObject {
    func didSelectPage(_ view: SelectAdsObjectiveViewController, objective: AdsObjective)
}

class SelectAdsObjectiveViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var delegate: SelectAdsObjectiveViewControllerDelegate?
    let adsObjective: [AdsObjective] = [.engagement, .reach]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Asset.darkGraphiteBlue
        self.configureTableView()
        self.setupNavBar()
    }

    func setupNavBar() {
        self.customNavigationBar(.primary, title: "Marketing Objective", leftBarButton: .back)
    }

    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.selectObjective, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.selectObjective)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }
}

extension SelectAdsObjectiveViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.adsObjective.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.selectObjective, for: indexPath as IndexPath) as? SelectObjectiveTableViewCell
        cell?.backgroundColor = UIColor.Asset.darkGray
        cell?.configCell(objective: self.adsObjective[indexPath.row])
        return cell ?? SelectObjectiveTableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectPage(self, objective: self.adsObjective[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
