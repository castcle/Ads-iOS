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
    
    enum CreateAdsViewControllerSection: Int, CaseIterable {
        case budget = 0
    }
    
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
        self.customNavigationBar(.primary, title: "Boot page", leftBarButton: .back)
    }
    
    func configureTableView() {
        self.tableView.isScrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsBudget, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsBudget)
//        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsNoHistory, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsNoHistory)
//        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsHistory, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsHistory)
//        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsHistoryFooter, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsHistoryFooter)
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
//        case AdsManagerViewControllerSection.history.rawValue:
//            if self.viewModel.adsLoaded {
//                return (self.viewModel.ads.isEmpty ? 1 : self.viewModel.ads.count)
//            } else {
//                return 1
//            }
//        case AdsManagerViewControllerSection.footer.rawValue:
//            return 1
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
        default:
            return UITableViewCell()
        }
    }
}
