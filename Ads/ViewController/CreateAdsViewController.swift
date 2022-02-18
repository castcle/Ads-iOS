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
//  CreateAdsViewController.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 15/2/2565 BE.
//

import UIKit
import Core

class CreateAdsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var viewModel = CreateAdsViewModel()
    enum CreateAdsViewControllerSection: Int, CaseIterable {
        case budget = 0
        case content
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Asset.darkGraphiteBlue
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideKeyboardWhenTapped()
        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.customNavigationBar(.primary, title: "Boost page", leftBarButton: .back)
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsBudget, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsBudget)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.choosePage, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.choosePage)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.chooseObjective, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.chooseObjective)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.campaignName, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.campaignName)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.boostMessage, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.boostMessage)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.dailyBudget, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.dailyBudget)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.duration, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.duration)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adPreview, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adPreview)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }
}

extension CreateAdsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CreateAdsViewControllerSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case CreateAdsViewControllerSection.budget.rawValue:
            return 1
        case CreateAdsViewControllerSection.content.rawValue:
            return self.viewModel.contents.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case CreateAdsViewControllerSection.budget.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsBudget, for: indexPath as IndexPath) as? AdsBudgetTableViewCell
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsBudgetTableViewCell()
        case CreateAdsViewControllerSection.content.rawValue:
            if self.viewModel.contents[indexPath.row] == .page {
                let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.choosePage, for: indexPath as IndexPath) as? ChoosePageTableViewCell
                cell?.backgroundColor = UIColor.clear
                cell?.configCell(page: self.viewModel.page)
                return cell ?? ChoosePageTableViewCell()
            } else if self.viewModel.contents[indexPath.row] == .objective {
                let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.chooseObjective, for: indexPath as IndexPath) as? ChooseObjectiveTableViewCell
                cell?.backgroundColor = UIColor.clear
                cell?.configCell(objective: self.viewModel.ads.objective)
                return cell ?? ChooseObjectiveTableViewCell()
            } else if self.viewModel.contents[indexPath.row] == .campaignName {
                let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.campaignName, for: indexPath as IndexPath) as? CampaignNameTableViewCell
                cell?.backgroundColor = UIColor.clear
                return cell ?? CampaignNameTableViewCell()
            } else if self.viewModel.contents[indexPath.row] == .campaignMessage {
                let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.boostMessage, for: indexPath as IndexPath) as? BoostMessageTableViewCell
                cell?.backgroundColor = UIColor.clear
                return cell ?? BoostMessageTableViewCell()
            } else if self.viewModel.contents[indexPath.row] == .dailyBudget {
                let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.dailyBudget, for: indexPath as IndexPath) as? DailyBudgetTableViewCell
                cell?.backgroundColor = UIColor.clear
                return cell ?? DailyBudgetTableViewCell()
            } else if self.viewModel.contents[indexPath.row] == .duration {
                let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.duration, for: indexPath as IndexPath) as? DurationTableViewCell
                cell?.backgroundColor = UIColor.clear
                return cell ?? DurationTableViewCell()
            } else if self.viewModel.contents[indexPath.row] == .adPreview {
                let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adPreview, for: indexPath as IndexPath) as? AdPreviewTableViewCell
                cell?.backgroundColor = UIColor.clear
                return cell ?? AdPreviewTableViewCell()
            } else {
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}
