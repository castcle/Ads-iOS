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
//  AdsDetailViewController.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 26/8/2565 BE.
//

import UIKit
import Core
import Networking

class AdsDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var infomationLabel: UILabel!
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var adSettingLabel: UILabel!
    @IBOutlet weak var infomationLine: UIView!
    @IBOutlet weak var reportLine: UIView!
    @IBOutlet weak var adSettingLine: UIView!

    var viewModel = AdDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Asset.darkGraphiteBlue
        self.configureTableView()
        self.menuView.backgroundColor = UIColor.Asset.cellBackground
        self.infomationLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.reportLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.adSettingLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.updateUi()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavBar()
    }

    func setupNavBar() {
        self.customNavigationBar(.primary, title: "Infomation", leftBarButton: .back)
    }

    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerFeedCell()
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsInfoName, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsInfoName)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsInfoStatus, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsInfoStatus)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsInfoBadget, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsInfoBadget)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsInfoDate, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsInfoDate)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsInfoSingle, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsInfoSingle)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsReport, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsReport)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }

    private func updateUi() {
        if self.viewModel.adsDetailType == .information {
            self.infomationLabel.textColor = UIColor.Asset.lightBlue
            self.infomationLine.backgroundColor = UIColor.Asset.lightBlue
            self.reportLabel.textColor = UIColor.Asset.white
            self.reportLine.backgroundColor = UIColor.clear
            self.adSettingLabel.textColor = UIColor.Asset.white
            self.adSettingLine.backgroundColor = UIColor.clear
        } else if self.viewModel.adsDetailType == .report {
            self.infomationLabel.textColor = UIColor.Asset.white
            self.infomationLine.backgroundColor = UIColor.clear
            self.reportLabel.textColor = UIColor.Asset.lightBlue
            self.reportLine.backgroundColor = UIColor.Asset.lightBlue
            self.adSettingLabel.textColor = UIColor.Asset.white
            self.adSettingLine.backgroundColor = UIColor.clear
        } else {
            self.infomationLabel.textColor = UIColor.Asset.white
            self.infomationLine.backgroundColor = UIColor.clear
            self.reportLabel.textColor = UIColor.Asset.white
            self.reportLine.backgroundColor = UIColor.clear
            self.adSettingLabel.textColor = UIColor.Asset.lightBlue
            self.adSettingLine.backgroundColor = UIColor.Asset.lightBlue
        }
    }

    @IBAction func informationAction(_ sender: Any) {
        self.viewModel.adsDetailType = .information
        self.updateUi()
        self.customNavigationBar(.primary, title: "Infomation", leftBarButton: .back)
        self.tableView.reloadData()
    }

    @IBAction func reportAction(_ sender: Any) {
        self.viewModel.adsDetailType = .report
        self.updateUi()
        self.customNavigationBar(.primary, title: "Report", leftBarButton: .back)
        self.tableView.reloadData()
    }

    @IBAction func adSettingAction(_ sender: Any) {
        self.viewModel.adsDetailType = .adSetting
        self.updateUi()
        self.customNavigationBar(.primary, title: "Ad Setting", leftBarButton: .back)
        self.tableView.reloadData()
    }
}

extension AdsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.adsDetailSection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.adsDetailSection[indexPath.row] == .campaignName {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsInfoName, for: indexPath as IndexPath) as? AdsInfoNameTableViewCell
            cell?.configCell(ads: self.viewModel.ads)
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsInfoNameTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .boostStatus {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsInfoStatus, for: indexPath as IndexPath) as? AdsInfoStatusTableViewCell
            cell?.configCell(ads: self.viewModel.ads)
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsInfoStatusTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .dateCteate {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsInfoSingle, for: indexPath as IndexPath) as? AdsInfoSingleTableViewCell
            cell?.configCell(title: "Date Created", value: self.viewModel.ads.createdDisplay.dateToString())
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsInfoSingleTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .budget {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsInfoBadget, for: indexPath as IndexPath) as? AdsInfoBadgetTableViewCell
            cell?.configCell(ads: self.viewModel.ads)
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsInfoBadgetTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .startAndEndDate {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsInfoDate, for: indexPath as IndexPath) as? AdsInfoDateTableViewCell
            cell?.configCell(ads: self.viewModel.ads)
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsInfoDateTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .budgetSpent {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsInfoSingle, for: indexPath as IndexPath) as? AdsInfoSingleTableViewCell
            let totalSpend: Double = (Double(self.viewModel.ads.duration) * self.viewModel.ads.dailyBudget)
            cell?.configCell(title: "Budget spent", value: "$\(totalSpend)")
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsInfoSingleTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .impression {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsInfoSingle, for: indexPath as IndexPath) as? AdsInfoSingleTableViewCell
            cell?.configCell(title: "Impression", value: "\(self.viewModel.ads.statistics.impression.organic + self.viewModel.ads.statistics.impression.paid)")
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsInfoSingleTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .cmp {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsInfoSingle, for: indexPath as IndexPath) as? AdsInfoSingleTableViewCell
            cell?.configCell(title: "CPM", value: "$ \(self.viewModel.ads.statistics.cpm)")
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsInfoSingleTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .report {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsReport, for: indexPath as IndexPath) as? AdsReportTableViewCell
            cell?.configCell(ads: self.viewModel.ads)
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsReportTableViewCell()
        } else {
            return UITableViewCell()
        }
    }
}
