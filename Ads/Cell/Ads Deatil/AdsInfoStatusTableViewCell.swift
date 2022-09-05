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
//  AdsInfoStatusTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 5/9/2565 BE.
//

import UIKit
import Core
import Networking
import SwiftColor

class AdsInfoStatusTableViewCell: UITableViewCell {

    @IBOutlet var statusTitleLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var dotImage: UIImageView!
    @IBOutlet var lineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusTitleLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.statusTitleLabel.textColor = UIColor.Asset.white
        self.statusLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.statusLabel.textColor = UIColor.Asset.white
        self.lineView.backgroundColor = UIColor.Asset.cellBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(ads: Ads) {
        self.statusLabel.text = ads.boostStatus.display
        if ads.boostStatus == .running {
            self.dotImage.image = UIColor.Asset.trendUp.toImage()
        } else if ads.boostStatus == .pause {
            self.dotImage.image = UIColor.Asset.lineGray.toImage()
        } else if ads.boostStatus == .end {
            self.dotImage.image = UIColor.Asset.trendDown.toImage()
        } else {
            self.dotImage.image = UIColor.Asset.warning.toImage()
        }
    }
}
