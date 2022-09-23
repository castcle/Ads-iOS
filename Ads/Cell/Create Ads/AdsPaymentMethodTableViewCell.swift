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
//  AdsPaymentMethodTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 11/3/2565 BE.
//

import UIKit
import Core
import Networking

protocol AdsPaymentMethodTableViewCellDelegate: AnyObject {
    func didChoosePaymentMethod(_ cell: AdsPaymentMethodTableViewCell)
}

class AdsPaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var adCreditTitleLabel: UILabel!
    @IBOutlet var adCreditLabel: UILabel!
    @IBOutlet var adsIcon: UIImageView!
    @IBOutlet var nextImage: UIImageView!
    @IBOutlet var line1View: UIView!
    @IBOutlet var line2View: UIView!

    var delegate: AdsPaymentMethodTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.asset(.bold, fontSize: .body)
        self.titleLabel.textColor = UIColor.Asset.white
        self.adCreditTitleLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.adCreditTitleLabel.textColor = UIColor.Asset.white
        self.adCreditLabel.font = UIFont.asset(.regular, fontSize: .head4)
        self.adCreditLabel.textColor = UIColor.Asset.lightBlue
        self.line1View.backgroundColor = UIColor.Asset.cellBackground
        self.line2View.backgroundColor = UIColor.Asset.cellBackground
        self.nextImage.image = UIImage.init(icon: .castcle(.next), size: CGSize(width: 25, height: 25), textColor: UIColor.Asset.white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func configCell(adsPaymentType: AdsPaymentType, wallet: Wallet) {
        self.adsIcon.image = adsPaymentType.image
        self.adCreditTitleLabel.text = adsPaymentType.display
        if adsPaymentType == .token {
            self.adCreditLabel.text = wallet.availableBalance
        } else {
            self.adCreditLabel.text = wallet.adsCredit
        }
    }

    public func configDisplayCell(adsPaymentType: AdsPaymentType, budget: Double) {
        self.nextImage.isHidden = true
        self.adsIcon.image = adsPaymentType.image
        self.adCreditTitleLabel.text = adsPaymentType.display
        self.adCreditLabel.text = "\(budget) CAST"
    }

    @IBAction func choosePageAction(_ sender: Any) {
        self.delegate?.didChoosePaymentMethod(self)
    }
}
