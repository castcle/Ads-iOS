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
import Networking

class CreateAdsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var viewModel = CreateAdsViewModel()

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
        self.customNavigationBar(.primary, title: "Boost Ad", leftBarButton: .back)
    }

    private func reloadButton() {
        let indexPath = IndexPath(row: self.viewModel.contents.count, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }

    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.choosePage, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.choosePage)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.chooseObjective, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.chooseObjective)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.campaignName, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.campaignName)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.boostMessage, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.boostMessage)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.dailyBudget, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.dailyBudget)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.duration, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.duration)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adPreview, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adPreview)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsPaymentMethod, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsPaymentMethod)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.dailyBid, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.dailyBid)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }
}

extension CreateAdsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.contents[indexPath.row] == .page {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.choosePage, for: indexPath as IndexPath) as? ChoosePageTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.delegate = self
            cell?.configCell(page: self.viewModel.page)
            return cell ?? ChoosePageTableViewCell()
        } else if self.viewModel.contents[indexPath.row] == .objective {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.chooseObjective, for: indexPath as IndexPath) as? ChooseObjectiveTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.delegate = self
            cell?.configCell(objective: self.viewModel.ads.objective)
            return cell ?? ChooseObjectiveTableViewCell()
        } else if self.viewModel.contents[indexPath.row] == .campaignName {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.campaignName, for: indexPath as IndexPath) as? CampaignNameTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.delegate = self
            return cell ?? CampaignNameTableViewCell()
        } else if self.viewModel.contents[indexPath.row] == .campaignMessage {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.boostMessage, for: indexPath as IndexPath) as? BoostMessageTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.delegate = self
            return cell ?? BoostMessageTableViewCell()
        } else if self.viewModel.contents[indexPath.row] == .dailyBudget {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.dailyBudget, for: indexPath as IndexPath) as? DailyBudgetTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.delegate = self
            return cell ?? DailyBudgetTableViewCell()
        } else if self.viewModel.contents[indexPath.row] == .duration {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.duration, for: indexPath as IndexPath) as? DurationTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.delegate = self
            return cell ?? DurationTableViewCell()
        } else if self.viewModel.contents[indexPath.row] == .dailyBid {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.dailyBid, for: indexPath as IndexPath) as? DailyBidTableViewCell
            cell?.backgroundColor = UIColor.clear
            return cell ?? DailyBidTableViewCell()
        } else if self.viewModel.contents[indexPath.row] == .paymentMethod {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsPaymentMethod, for: indexPath as IndexPath) as? AdsPaymentMethodTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.delegate = self
            cell?.configCell(adsPaymentType: self.viewModel.ads.payment)
            return cell ?? AdsPaymentMethodTableViewCell()
        } else if self.viewModel.contents[indexPath.row] == .adPreview {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adPreview, for: indexPath as IndexPath) as? AdPreviewTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.configCell(ads: self.viewModel.ads)
            cell?.delegate = self
            return cell ?? AdPreviewTableViewCell()
        } else {
            return UITableViewCell()
        }
    }
}

extension CreateAdsViewController: ChoosePageTableViewCellDelegate {
    func didChoosePage(_ cell: ChoosePageTableViewCell) {
        let viewController = AdsOpener.open(.selectAdsPage(self.viewModel.page.castcleId)) as? SelectAdsPageViewController
        viewController?.delegate = self
        self.navigationController?.pushViewController(viewController ?? SelectAdsPageViewController(), animated: true)
    }
}

extension CreateAdsViewController: ChooseObjectiveTableViewCellDelegate {
    func didChooseObjective(_ cell: ChooseObjectiveTableViewCell) {
        let viewController = AdsOpener.open(.selectAdsObjective(self.viewModel.ads.objective)) as? SelectAdsObjectiveViewController
        viewController?.delegate = self
        self.navigationController?.pushViewController(viewController ?? SelectAdsObjectiveViewController(), animated: true)
    }
}

extension CreateAdsViewController: CampaignNameTableViewCellDelegate {
    func didEditChange(_ cell: CampaignNameTableViewCell, campaignName: String) {
        self.viewModel.ads.campaignName = campaignName
        self.reloadButton()
    }
}

extension CreateAdsViewController: BoostMessageTableViewCellDelegate {
    func didEditChange(_ cell: BoostMessageTableViewCell, massage: String) {
        self.viewModel.ads.campaignMessage = massage
        self.reloadButton()
    }
}

extension CreateAdsViewController: DailyBudgetTableViewCellDelegate {
    func didEditChange(_ cell: DailyBudgetTableViewCell, budget: Int) {
        self.viewModel.ads.dailyBudget = Double(budget)
    }
}

extension CreateAdsViewController: DurationTableViewCellDelegate {
    func didEditChange(_ cell: DurationTableViewCell, duration: Int) {
        self.viewModel.ads.duration = duration
    }
}

extension CreateAdsViewController: AdsPaymentMethodTableViewCellDelegate {
    func didChoosePaymentMethod(_ cell: AdsPaymentMethodTableViewCell) {
        let viewController = AdsOpener.open(.selectAdsPayment) as? SelectAdsPaymentViewController
        viewController?.delegate = self
        self.navigationController?.pushViewController(viewController ?? SelectAdsPaymentViewController(), animated: true)
    }
}

extension CreateAdsViewController: AdPreviewTableViewCellDelegate {
    func didConfirm(_ cell: AdPreviewTableViewCell) {
        self.navigationController?.pushViewController(AdsOpener.open(.adsPreview(AdsPreviewViewModel(ads: self.viewModel.ads, page: self.viewModel.page))), animated: true)
    }
}

extension CreateAdsViewController: SelectAdsPageViewControllerDelegate {
    func didSelectPage(_ view: SelectAdsPageViewController, page: Page) {
        self.viewModel.page = page
        self.tableView.reloadData()
    }
}

extension CreateAdsViewController: SelectAdsObjectiveViewControllerDelegate {
    func didSelectPage(_ view: SelectAdsObjectiveViewController, objective: AdsObjective) {
        self.viewModel.ads.objective = objective
        self.tableView.reloadData()
    }
}

extension CreateAdsViewController: SelectAdsPaymentViewControllerDelegate {
    func didSelectPaymenyMethod(_ view: SelectAdsPaymentViewController, adsPaymentType: AdsPaymentType) {
        self.viewModel.ads.payment = adsPaymentType
        self.tableView.reloadData()
    }
}
