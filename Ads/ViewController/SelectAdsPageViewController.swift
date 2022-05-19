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
//  SelectAdsPageViewController.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 23/2/2565 BE.
//

import UIKit
import Core
import RealmSwift

protocol SelectAdsPageViewControllerDelegate: AnyObject {
    func didSelectPage(_ view: SelectAdsPageViewController, page: Page)
}

class SelectAdsPageViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var delegate: SelectAdsPageViewControllerDelegate?
    var pages: Results<Page>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.Asset.darkGraphiteBlue
        self.configureTableView()
        self.setupNavBar()
        do {
            let realm = try Realm()
            self.pages = realm.objects(Page.self).sorted(byKeyPath: "id")
        } catch let error as NSError {
            print(error)
        }
    }

    func setupNavBar() {
        self.customNavigationBar(.primary, title: "Page", leftBarButton: .back)
    }

    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: AdsNibVars.TableViewCell.selectPageAds, bundle: ConfigBundle.ads), forCellReuseIdentifier: AdsNibVars.TableViewCell.selectPageAds)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }
}

extension SelectAdsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdsNibVars.TableViewCell.selectPageAds, for: indexPath as IndexPath) as? SelectPageAdsTableViewCell
        cell?.backgroundColor = UIColor.Asset.darkGray
        cell?.configCell(page: self.pages[indexPath.row])
        return cell ?? SelectPageAdsTableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectPage(self, page: self.pages[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
