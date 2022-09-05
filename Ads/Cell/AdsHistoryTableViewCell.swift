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
//  AdsHistoryTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 4/2/2565 BE.
//

import UIKit
import Core
import Networking
import ActiveLabel
import SwiftColor
import Kingfisher

class AdsHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var dotImage: UIImageView!
    @IBOutlet weak var campaignLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var approvedLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var totalSpendLabel: ActiveLabel!
    @IBOutlet weak var impressionLabel: UILabel!
    @IBOutlet weak var approvedView: UIView!
    @IBOutlet weak var lineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImage.circle()
        self.avatarImage.image = UIImage.Asset.userPlaceholder
        self.dotImage.circle()
        self.lineView.backgroundColor = UIColor.Asset.lineGray
        self.campaignLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.campaignLabel.textColor = UIColor.Asset.white
        self.idLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.idLabel.textColor = UIColor.Asset.white
        self.statusLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.statusLabel.textColor = UIColor.Asset.white
        self.approvedLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.approvedLabel.textColor = UIColor.Asset.white
        self.displayNameLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.displayNameLabel.textColor = UIColor.Asset.white
        self.dateLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.dateLabel.textColor = UIColor.Asset.white
        self.detailLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.detailLabel.textColor = UIColor.Asset.white
        self.impressionLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.impressionLabel.textColor = UIColor.Asset.lightBlue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(ads: Ads) {
        self.campaignLabel.text = ads.campaignName
        self.idLabel.text = ads.campaignCode
        self.detailLabel.text = ads.campaignMessage
        self.approvedLabel.text = ads.adStatus.display
        self.statusLabel.text = ads.boostStatus.display
        if ads.adStatus == .approved {
            self.approvedView.capsule(color: UIColor.Asset.trendUp)
        } else if ads.adStatus == .declinded {
            self.approvedView.capsule(color: UIColor.Asset.trendDown)
        } else if ads.adStatus == .canceled {
            self.approvedView.capsule(color: UIColor.Asset.warning)
        } else {
            self.approvedView.capsule(color: UIColor.Asset.lineGray)
        }
        if ads.boostType == .user {
            self.typeImage.image = UIImage.Asset.typePageIcon
            self.displayNameLabel.text = ads.user.displayName
            let url = URL(string: ads.user.images.avatar.thumbnail)
            self.avatarImage.kf.setImage(with: url, placeholder: UIImage.Asset.placeholder, options: [.transition(.fade(0.35))])
        } else {
            self.typeImage.image = UIImage.Asset.typeCastIcon
        }
        if ads.boostStatus == .running {
            self.dotImage.isHidden = false
            self.statusLabel.isHidden = false
            self.dotImage.image = UIColor.Asset.trendUp.toImage()
            self.dateLabel.text = "\(ads.createdDisplay.dateToString()) \(ads.createdDisplay.timeToString())"
        } else if ads.boostStatus == .pause {
            self.dotImage.isHidden = false
            self.statusLabel.isHidden = false
            self.dotImage.image = UIColor.Asset.lineGray.toImage()
            self.dateLabel.text = "\(ads.createdDisplay.dateToString()) \(ads.createdDisplay.timeToString())"
        } else if ads.boostStatus == .end {
            self.dotImage.isHidden = false
            self.statusLabel.isHidden = false
            self.dotImage.image = UIColor.Asset.trendDown.toImage()
            self.dateLabel.text = "\(ads.createdDisplay.dateToString()) \(ads.createdDisplay.timeToString())"
        } else {
            self.dotImage.isHidden = true
            self.statusLabel.isHidden = true
            self.dateLabel.text = ""
        }

        let totalSpend: Double = (Double(ads.duration) * ads.dailyBudget)
        self.totalSpendLabel.text = "Total spending : $\(totalSpend)"
        self.totalSpendLabel.customize { label in
            label.font = UIFont.asset(.bold, fontSize: .body)
            label.numberOfLines = 1
            label.textColor = UIColor.Asset.white
            let amountType = ActiveType.custom(pattern: "\\$\(totalSpend)")
            label.enabledTypes = [amountType]
            label.customColor[amountType] = UIColor.Asset.lightBlue
        }
        self.impressionLabel.text = "\(ads.statistics.impression.organic + ads.statistics.impression.paid) impressions"
    }
}
