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
//  AdsCreditsCollectionViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 3/2/2565 BE.
//

import UIKit
import Core
import SwiftColor
import ActiveLabel

class AdsCreditsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var balanceView: UIView!
    @IBOutlet var balanceTitleLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var coinImage: UIImageView!
    @IBOutlet var noticLabel: ActiveLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.balanceView.custom(color: UIColor.Asset.white, cornerRadius: 10)
        self.balanceTitleLabel.font = UIFont.asset(.regular, fontSize: .head4)
        self.balanceTitleLabel.textColor = UIColor.Asset.black
        self.balanceLabel.font = UIFont.asset(.regular, fontSize: .head2)
        self.balanceLabel.textColor = UIColor.Asset.black
        self.coinImage.image = UIImage.init(icon: .castcle(.coin), size: CGSize(width: 25, height: 25), textColor: UIColor.Asset.black)
        self.noticLabel.customize { label in
            label.font = UIFont.asset(.regular, fontSize: .small)
            label.numberOfLines = 2
            label.textColor = UIColor.Asset.white
            let learnMore = ActiveType.custom(pattern: "Learn more")
            label.enabledTypes = [learnMore]
            label.customColor[learnMore] = UIColor.Asset.lightBlue
            label.customSelectedColor[learnMore] = UIColor.Asset.gray
            label.handleCustomTap(for: learnMore) { _ in
            }
        }
    }
}
