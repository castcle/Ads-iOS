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
//  BoostMessageTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 17/2/2565 BE.
//

import UIKit
import Core
import Networking
import UITextView_Placeholder

protocol BoostMessageTableViewCellDelegate: AnyObject {
    func didEditChange(_ cell: BoostMessageTableViewCell, massage: String)
}

class BoostMessageTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var massageTextView: UITextView!
    @IBOutlet var massageView: UIView!

    var delegate: BoostMessageTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.asset(.bold, fontSize: .body)
        self.titleLabel.textColor = UIColor.Asset.white
        self.massageView.custom(color: UIColor.Asset.cellBackground, cornerRadius: 10, borderWidth: 1, borderColor: UIColor.Asset.black)
        self.massageTextView.delegate = self
        self.massageTextView.font = UIFont.asset(.regular, fontSize: .overline)
        self.massageTextView.textColor = UIColor.Asset.white
        self.massageTextView.placeholder = "Type something to advertise your page"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configDisplayCell(ads: Ads) {
        self.massageTextView.isEditable = false
        self.massageTextView.text = ads.campaignMessage
    }

    func textViewDidChange(_ textView: UITextView) {
        let massage = textView.text ?? ""
        textView.text = massage.substringWithRange(range: 280)
        self.delegate?.didEditChange(self, massage: massage.substringWithRange(range: 280))
    }
}
