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
//  AdPreviewTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 17/2/2565 BE.
//

import UIKit
import Core
import Networking

protocol AdPreviewTableViewCellDelegate: AnyObject {
    func didConfirm(_ cell: AdPreviewTableViewCell)
}

class AdPreviewTableViewCell: UITableViewCell {

    @IBOutlet var adPreviewButton: UIButton!

    var delegate: AdPreviewTableViewCellDelegate?
    private var adsRequest: AdsRequest = AdsRequest()
    private var wallet: Wallet = Wallet()
    private var isValidated: Bool {
        if self.adsRequest.campaignName.isEmpty {
            return false
        } else if (self.adsRequest.paymentMethod == .token) && (self.wallet.availableBalanceNumber == 0) {
            return false
        } else if (self.adsRequest.paymentMethod == .adCredit) && (self.wallet.adsCreditNumber == 0) {
            return false
        } else {
            return true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(adsRequest: AdsRequest, wallet: Wallet) {
        self.adsRequest = adsRequest
        self.wallet = wallet
        self.updateButton()
    }

    private func updateButton() {
        self.adPreviewButton.titleLabel?.font = UIFont.asset(.regular, fontSize: .head4)
        self.adPreviewButton.setTitleColor(UIColor.Asset.white, for: .normal)
        if self.isValidated {
            self.adPreviewButton.setBackgroundImage(UIColor.Asset.lightBlue.toImage(), for: .normal)
            self.adPreviewButton.capsule(color: UIColor.clear, borderWidth: 1, borderColor: UIColor.clear)
        } else {
            self.adPreviewButton.setBackgroundImage(UIColor.Asset.gray.toImage(), for: .normal)
            self.adPreviewButton.capsule(color: UIColor.clear, borderWidth: 1, borderColor: UIColor.Asset.gray)
        }
    }

    @IBAction func adPreviewAction(_ sender: Any) {
        if self.isValidated {
            self.delegate?.didConfirm(self)
        }
    }
}
