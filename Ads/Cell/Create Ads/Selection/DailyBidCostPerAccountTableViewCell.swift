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
//  DailyBidCostPerAccountTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 14/6/2565 BE.
//

import UIKit
import Core
import Networking

protocol DailyBidCostPerAccountTableViewCellDelegate: AnyObject {
    func didCostChange(_ dailyBidCostPerAccountTableViewCell: DailyBidCostPerAccountTableViewCell, cost: Int)
}

class DailyBidCostPerAccountTableViewCell: UITableViewCell {

    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var typeImage: UIImageView!
    @IBOutlet var lineView: UIView!
    @IBOutlet var selectIcon: UIImageView!
    @IBOutlet var costView: UIView!
    @IBOutlet var costTextField: UITextField!

    public var delegate: DailyBidCostPerAccountTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.typeLabel.font = UIFont.asset(.bold, fontSize: .body)
        self.typeLabel.textColor = UIColor.Asset.white
        self.detailLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.detailLabel.textColor = UIColor.Asset.white
        self.noteLabel.font = UIFont.asset(.regular, fontSize: .small)
        self.noteLabel.textColor = UIColor.Asset.white
        self.lineView.backgroundColor = UIColor.Asset.darkGraphiteBlue
        self.selectIcon.image = UIImage.init(icon: .castcle(.checkmark), size: CGSize(width: 20, height: 20), textColor: UIColor.Asset.lightBlue)
        self.costTextField.font = UIFont.asset(.regular, fontSize: .small)
        self.costTextField.textColor = UIColor.Asset.white
        self.costTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.costView.capsule(color: UIColor.Asset.darkGraphiteBlue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        let costStr = textField.text ?? ""
        let newCostStr = costStr.replacingOccurrences(of: "$ ", with: "")
        textField.text = (newCostStr.isEmpty ? "" : "$ \(newCostStr)")
        self.delegate?.didCostChange(self, cost: Int(newCostStr) ?? 0)
    }

    public func configCell(dailyBidType: DailyBidType, oldSelect: DailyBidType, cost: Int) {
        self.typeImage.image = dailyBidType.image
        self.typeLabel.text = dailyBidType.display
        self.detailLabel.text = dailyBidType.notice
        self.costTextField.text = (cost > 0 ? "$ \(cost)" : "")
        if dailyBidType == oldSelect {
            self.selectIcon.isHidden = false
        } else {
            self.selectIcon.isHidden = true
        }
    }
}
