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
//  AdsReportTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 6/9/2565 BE.
//

import UIKit
import Core
import Networking

class AdsReportTableViewCell: UITableViewCell {

    @IBOutlet weak var impressionTitleLabel: UILabel!
    @IBOutlet weak var reachTitleLabel: UILabel!
    @IBOutlet weak var engagementTitleLabel: UILabel!
    @IBOutlet weak var impressionOrganicTitleLabel: UILabel!
    @IBOutlet weak var impressionPaidTitleLabel: UILabel!
    @IBOutlet weak var reachOrganicTitleLabel: UILabel!
    @IBOutlet weak var reachPaidTitleLabel: UILabel!
    @IBOutlet weak var impressionOrganicLabel: UILabel!
    @IBOutlet weak var impressionPaidLabel: UILabel!
    @IBOutlet weak var reachOrganicLabel: UILabel!
    @IBOutlet weak var reachPaidLabel: UILabel!
    @IBOutlet weak var likeTitleLabel: UILabel!
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var recastTitleLabel: UILabel!
    @IBOutlet weak var quoteCastTitleLabel: UILabel!
    @IBOutlet weak var clickTitleLabel: UILabel!
    @IBOutlet weak var farmTitleLabel: UILabel!
    @IBOutlet weak var followerTitleLabel: UILabel!
    @IBOutlet weak var rewardTitleLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var recastLabel: UILabel!
    @IBOutlet weak var quoteCastLabel: UILabel!
    @IBOutlet weak var clickLabel: UILabel!
    @IBOutlet weak var farmLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var impressionView: UIView!
    @IBOutlet weak var reachView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.impressionTitleLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.impressionTitleLabel.textColor = UIColor.Asset.white
        self.reachTitleLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.reachTitleLabel.textColor = UIColor.Asset.white
        self.engagementTitleLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.engagementTitleLabel.textColor = UIColor.Asset.white
        self.impressionOrganicTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.impressionOrganicTitleLabel.textColor = UIColor.Asset.white
        self.impressionPaidTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.impressionPaidTitleLabel.textColor = UIColor.Asset.white
        self.reachOrganicTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.reachOrganicTitleLabel.textColor = UIColor.Asset.white
        self.reachPaidTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.reachPaidTitleLabel.textColor = UIColor.Asset.white
        self.likeTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.likeTitleLabel.textColor = UIColor.Asset.white
        self.commentTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.commentTitleLabel.textColor = UIColor.Asset.white
        self.recastTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.recastTitleLabel.textColor = UIColor.Asset.white
        self.quoteCastTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.quoteCastTitleLabel.textColor = UIColor.Asset.white
        self.clickTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.clickTitleLabel.textColor = UIColor.Asset.white
        self.farmTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.farmTitleLabel.textColor = UIColor.Asset.white
        self.followerTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.followerTitleLabel.textColor = UIColor.Asset.white
        self.rewardTitleLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.rewardTitleLabel.textColor = UIColor.Asset.white
        self.impressionOrganicLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.impressionOrganicLabel.textColor = UIColor.Asset.lightBlue
        self.impressionPaidLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.impressionPaidLabel.textColor = UIColor.Asset.lightBlue
        self.reachOrganicLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.reachOrganicLabel.textColor = UIColor.Asset.lightBlue
        self.reachPaidLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.reachPaidLabel.textColor = UIColor.Asset.lightBlue
        self.likeLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.likeLabel.textColor = UIColor.Asset.lightBlue
        self.commentLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.commentLabel.textColor = UIColor.Asset.lightBlue
        self.recastLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.recastLabel.textColor = UIColor.Asset.lightBlue
        self.quoteCastLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.quoteCastLabel.textColor = UIColor.Asset.lightBlue
        self.clickLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.clickLabel.textColor = UIColor.Asset.lightBlue
        self.farmLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.farmLabel.textColor = UIColor.Asset.lightBlue
        self.followerLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.followerLabel.textColor = UIColor.Asset.lightBlue
        self.rewardLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.rewardLabel.textColor = UIColor.Asset.lightBlue
        self.impressionView.custom(cornerRadius: 10.0, borderWidth: 1.0, borderColor: UIColor.Asset.lightBlue)
        self.reachView.custom(cornerRadius: 10.0, borderWidth: 1.0, borderColor: UIColor.Asset.lightBlue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(ads: Ads) {
        self.impressionOrganicLabel.text = "\(ads.statistics.impression.organic)"
        self.impressionPaidLabel.text = "\(ads.statistics.impression.paid)"
        self.reachOrganicLabel.text = "\(ads.statistics.reach.organic)"
        self.reachPaidLabel.text = "\(ads.statistics.reach.paid)"
        self.likeLabel.text = "\(ads.engagement.likes)"
        self.commentLabel.text = "\(ads.engagement.comments)"
        self.recastLabel.text = "\(ads.engagement.recast)"
        self.quoteCastLabel.text = "\(ads.engagement.quotecast)"
        self.clickLabel.text = "\(ads.engagement.clicks)"
        self.farmLabel.text = "\(ads.engagement.farm)"
        self.followerLabel.text = "\(ads.engagement.followerGain)"
        self.rewardLabel.text = "\(ads.engagement.rewardDistributed)"
    }
}
