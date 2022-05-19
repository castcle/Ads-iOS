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
import Component
import SwiftColor

class AdsManagerViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var filterTitleLabel: UILabel!
    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var filterIcon: UIImageView!
    @IBOutlet var boostButton: UIButton!

    enum AdsManagerViewControllerSection: Int, CaseIterable {
        case history = 0
        case footer
    }

    var viewModel = AdsManagerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Asset.darkGraphiteBlue
        self.configureTableView()
        self.filterTitleLabel.font = UIFont.asset(.bold, fontSize: .head3)
        self.filterTitleLabel.textColor = UIColor.Asset.white
        self.filterLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.filterLabel.textColor = UIColor.Asset.lightBlue
        self.filterIcon.image = UIImage.init(icon: .castcle(.settings), size: CGSize(width: 25, height: 25), textColor: UIColor.Asset.white)
        self.boostButton.titleLabel?.font = UIFont.asset(.regular, fontSize: .head4)
        self.boostButton.setTitleColor(UIColor.Asset.white, for: .normal)
        self.boostButton.setBackgroundImage(UIColor.Asset.lightBlue.toImage(), for: .normal)
        self.boostButton.capsule(color: UIColor.clear, borderWidth: 1, borderColor: UIColor.clear)

        self.tableView.coreRefresh.addHeadRefresh(animator: FastAnimator()) {
            self.tableView.coreRefresh.resetNoMore()
            self.tableView.isScrollEnabled = false
            self.viewModel.adsLoaded = false
            self.tableView.reloadData()
            self.viewModel.reloadData()
        }

        self.tableView.coreRefresh.addFootRefresh(animator: NormalFooterAnimator()) {
            if self.viewModel.adsCanLoad {
                self.viewModel.getAds()
            } else {
                self.tableView.coreRefresh.noticeNoMoreData()
            }
        }

        self.viewModel.didGetAdsFinish = {
            self.tableView.coreRefresh.endHeaderRefresh()
            self.tableView.coreRefresh.endLoadingMore()
            self.tableView.isScrollEnabled = true
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavBar()
    }

    func setupNavBar() {
        self.customNavigationBar(.primary, title: "Ad Manager", leftBarButton: .back)
    }

    func configureTableView() {
        self.tableView.isScrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsNoHistory, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsNoHistory)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsHistory, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsHistory)
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.adsHistoryFooter, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.adsHistoryFooter)
        self.tableView.register(UINib(nibName: ComponentNibVars.TableViewCell.skeleton, bundle: ConfigBundle.component), forCellReuseIdentifier: ComponentNibVars.TableViewCell.skeleton)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }

    @IBAction func filterAction(_ sender: Any) {
        let actionSheet = CCActionSheet()
        let allButton = CCAction(title: HistoryFilterType.all.rawValue, color: UIColor.Asset.lightBlue) {
            actionSheet.dismissActionSheet()
            self.viewModel.filterType = .all
            self.updateFilterLabel()
        }
        let dayButton = CCAction(title: HistoryFilterType.day.rawValue) {
            actionSheet.dismissActionSheet()
            self.viewModel.filterType = .day
            self.updateFilterLabel()
        }
        let weekButton = CCAction(title: HistoryFilterType.week.rawValue) {
            actionSheet.dismissActionSheet()
            self.viewModel.filterType = .week
            self.updateFilterLabel()
        }
        let monthButton = CCAction(title: HistoryFilterType.month.rawValue) {
            actionSheet.dismissActionSheet()
            self.viewModel.filterType = .month
            self.updateFilterLabel()
        }
        let cancelButton = CCAction(title: "Cancel", color: UIColor.Asset.denger) {
            actionSheet.dismissActionSheet()
        }

        actionSheet.addActions([allButton, dayButton, weekButton, monthButton, cancelButton])
        Utility.currentViewController().present(actionSheet, animated: true, completion: nil)
    }

    private func updateFilterLabel() {
        if self.viewModel.filterType == .all {
            self.filterLabel.text = ""
        } else {
            self.filterLabel.text = self.viewModel.filterType.rawValue
        }
    }

    @IBAction func boostAction(_ sender: Any) {
        Utility.currentViewController().navigationController?.pushViewController(AdsOpener.open(.createAds), animated: true)
    }
}

extension AdsManagerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return AdsManagerViewControllerSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case AdsManagerViewControllerSection.history.rawValue:
            if self.viewModel.adsLoaded {
                return (self.viewModel.ads.isEmpty ? 1 : self.viewModel.ads.count)
            } else {
                return 1
            }
        case AdsManagerViewControllerSection.footer.rawValue:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case AdsManagerViewControllerSection.history.rawValue:
            if self.viewModel.adsLoaded {
                if self.viewModel.ads.isEmpty {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsNoHistory, for: indexPath as IndexPath) as? AdsNoHistoryTableViewCell
                    cell?.backgroundColor = UIColor.clear
                    return cell ?? AdsNoHistoryTableViewCell()
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsHistory, for: indexPath as IndexPath) as? AdsHistoryTableViewCell
                    cell?.backgroundColor = UIColor.Asset.darkGray
                    return cell ?? AdsHistoryTableViewCell()
                }
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ComponentNibVars.TableViewCell.skeleton, for: indexPath as IndexPath) as? SkeletonFeedTableViewCell
                cell?.backgroundColor = UIColor.Asset.darkGray
                cell?.configCell()
                return cell ?? SkeletonFeedTableViewCell()
            }
        case AdsManagerViewControllerSection.footer.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.adsHistoryFooter, for: indexPath as IndexPath) as? AdsHistoryFooterTableViewCell
            cell?.backgroundColor = UIColor.clear
            return cell ?? AdsHistoryFooterTableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
