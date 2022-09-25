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
//  AdsStatusTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 24/9/2565 BE.
//

import UIKit
import Core
import Networking

protocol AdsStatusTableViewCellDelegate: AnyObject {
    func didChangeStatus(_ cell: AdsStatusTableViewCell)
}

class AdsStatusTableViewCell: UITableViewCell {

    @IBOutlet var boostStatusTitleLabel: UILabel!
    @IBOutlet var adsStatusTitleLabel: UILabel!
    @IBOutlet var boostStatusLabel: UILabel!
    @IBOutlet var dotImage: UIImageView!
    @IBOutlet weak var adsStatusLabel: UILabel!
    @IBOutlet weak var adsStatusView: UIView!
    @IBOutlet weak var boostStatusView: UIView!
    @IBOutlet weak var downImage: UIImageView!

    var delegate: AdsStatusTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.boostStatusTitleLabel.font = UIFont.asset(.bold, fontSize: .body)
        self.boostStatusTitleLabel.textColor = UIColor.Asset.white
        self.adsStatusTitleLabel.font = UIFont.asset(.bold, fontSize: .body)
        self.adsStatusTitleLabel.textColor = UIColor.Asset.white
        self.boostStatusLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.boostStatusLabel.textColor = UIColor.Asset.black
        self.adsStatusLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.adsStatusLabel.textColor = UIColor.Asset.white
        self.boostStatusView.capsule(color: UIColor.Asset.white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(ads: Ads) {
        self.boostStatusLabel.text = ads.boostStatus.display
        if ads.boostStatus == .running {
            self.dotImage.image = UIColor.Asset.trendUp.toImage()
            self.downImage.isHidden = false
        } else if ads.boostStatus == .pause {
            self.dotImage.image = UIColor.Asset.lineGray.toImage()
            self.downImage.isHidden = false
        } else if ads.boostStatus == .end {
            self.dotImage.image = UIColor.Asset.trendDown.toImage()
            self.downImage.isHidden = true
        } else {
            self.dotImage.image = UIColor.Asset.warning.toImage()
            self.downImage.isHidden = true
        }
        self.adsStatusLabel.text = ads.adStatus.display
        if ads.adStatus == .approved {
            self.adsStatusView.capsule(color: UIColor.Asset.trendUp)
        } else if ads.adStatus == .declinded {
            self.adsStatusView.capsule(color: UIColor.Asset.trendDown)
        } else if ads.adStatus == .canceled {
            self.adsStatusView.capsule(color: UIColor.Asset.warning)
        } else {
            self.adsStatusView.capsule(color: UIColor.Asset.lineGray)
        }
    }

    @IBAction func boostStatusAction(_ sender: Any) {
        self.delegate?.didChangeStatus(self)
    }
}
