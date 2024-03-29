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
import Component

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
        CCLoading.shared.show(text: "Loading")
        self.viewModel.getAdsDetail()
        self.viewModel.didGetAdsDetailFinish = {
            CCLoading.shared.dismiss()
            self.tableView.reloadData()
        }
        self.viewModel.didAdsActionFinish = {
            self.viewModel.getAdsDetail()
        }
        self.viewModel.didError = {
            CCLoading.shared.dismiss()
        }
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
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.choosePage, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.choosePage)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.chooseObjective, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.chooseObjective)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.campaignName, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.campaignName)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.boostMessage, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.boostMessage)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.dailyBudget, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.dailyBudget)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.duration, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.duration)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsPaymentMethod, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsPaymentMethod)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adPreview, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adPreview)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsStatus, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsStatus)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsUser, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsUser)
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
        if self.viewModel.adsDetailSection[indexPath.row] == .content {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsUser, for: indexPath as IndexPath) as? AdsUserTableViewCell
            cell?.configCell(ads: self.viewModel.ads)
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsUserTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .campaignName {
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
        } else if self.viewModel.adsDetailSection[indexPath.row] == .status {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsStatus, for: indexPath as IndexPath) as? AdsStatusTableViewCell
            cell?.configCell(ads: self.viewModel.ads)
            cell?.backgroundColor = UIColor.clear
            cell?.delegate = self
            return cell ?? AdsStatusTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .page {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.choosePage, for: indexPath as IndexPath) as? ChoosePageTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.configCell(userInfo: self.viewModel.ads.user)
            return cell ?? ChoosePageTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .objective {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.chooseObjective, for: indexPath as IndexPath) as? ChooseObjectiveTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.configCell(objective: self.viewModel.ads.objective, isDisplay: true)
            return cell ?? ChooseObjectiveTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .campaignNameSetting {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.campaignName, for: indexPath as IndexPath) as? CampaignNameTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.configDisplayCell(ads: self.viewModel.ads)
            return cell ?? CampaignNameTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .campaignMessage {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.boostMessage, for: indexPath as IndexPath) as? BoostMessageTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.configDisplayCell(ads: self.viewModel.ads)
            return cell ?? BoostMessageTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .dailyBudget {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.dailyBudget, for: indexPath as IndexPath) as? DailyBudgetTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.configDisplayCell(ads: self.viewModel.ads)
            return cell ?? DailyBudgetTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .duration {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.duration, for: indexPath as IndexPath) as? DurationTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.configDisplayCell(ads: self.viewModel.ads)
            return cell ?? DurationTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .paymentMethod {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsPaymentMethod, for: indexPath as IndexPath) as? AdsPaymentMethodTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.configDisplayCell(adsPaymentType: self.viewModel.ads.payment, budget: (self.viewModel.ads.dailyBudget * Double(self.viewModel.ads.duration)))
            return cell ?? AdsPaymentMethodTableViewCell()
        } else if self.viewModel.adsDetailSection[indexPath.row] == .cancel {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adPreview, for: indexPath as IndexPath) as? AdPreviewTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.configCellCancelButton()
            cell?.delegate = self
            return cell ?? AdPreviewTableViewCell()
        } else {
            return UITableViewCell()
        }
    }

    private func cancelAds() {
        CCLoading.shared.show(text: "Canceling")
        self.viewModel.cancelAds()
    }

    private func endAds() {
        CCLoading.shared.show(text: "Ending")
        self.viewModel.endAds()
    }

    private func runAds() {
        CCLoading.shared.show(text: "Running")
        self.viewModel.runAds()
    }

    private func pauseAds() {
        CCLoading.shared.show(text: "Pausing")
        self.viewModel.pauseAds()
    }
}

extension AdsDetailViewController: AdPreviewTableViewCellDelegate {
    func didConfirm(_ cell: AdPreviewTableViewCell) {
        let viewController = AdsOpener.open(.adsPopup(false)) as? AdsPopupViewController
        viewController?.delegate = self
        Utility.currentViewController().presentPanModal(viewController ?? AdsPopupViewController())
    }
}

extension AdsDetailViewController: AdsStatusTableViewCellDelegate {
    func didChangeStatus(_ cell: AdsStatusTableViewCell) {
        if self.viewModel.ads.boostStatus == .running || self.viewModel.ads.boostStatus == .pause {
            let actionSheet = CCActionSheet()
            let pauseButton = CCAction(title: "Pause", color: UIColor.Asset.white) {
                actionSheet.dismissActionSheet()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.pauseAds()
                }
            }
            let runningButton = CCAction(title: "Renning", color: UIColor.Asset.white) {
                actionSheet.dismissActionSheet()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.runAds()
                }
            }
            let endButton = CCAction(title: "End", color: UIColor.Asset.white) {
                actionSheet.dismissActionSheet()
                let viewController = AdsOpener.open(.adsPopup(true)) as? AdsPopupViewController
                viewController?.delegate = self
                Utility.currentViewController().presentPanModal(viewController ?? AdsPopupViewController())
            }
            if self.viewModel.ads.boostStatus == .running {
                actionSheet.addActions([pauseButton, endButton])
            } else if self.viewModel.ads.boostStatus == .pause {
                actionSheet.addActions([runningButton, endButton])
            }
            Utility.currentViewController().present(actionSheet, animated: true, completion: nil)
        }
    }
}

extension AdsDetailViewController: AdsPopupViewControllerDelegate {
    func adsPopupViewController(didAction view: AdsPopupViewController, isEnd: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if isEnd {
                self.endAds()
            } else {
                self.cancelAds()
            }
        }
    }
}
