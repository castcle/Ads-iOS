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
//  ConfirmButtonTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 23/2/2565 BE.
//

import UIKit
import Core

protocol ConfirmButtonTableViewCellDelegate: AnyObject {
    func didConfirm(_ cell: ConfirmButtonTableViewCell)
}

class ConfirmButtonTableViewCell: UITableViewCell {

    @IBOutlet var confirmButton: UIButton!

    var delegate: ConfirmButtonTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.confirmButton.titleLabel?.font = UIFont.asset(.regular, fontSize: .head4)
        self.confirmButton.setTitleColor(UIColor.Asset.white, for: .normal)
        self.confirmButton.setBackgroundImage(UIColor.Asset.lightBlue.toImage(), for: .normal)
        self.confirmButton.capsule(color: UIColor.clear, borderWidth: 1, borderColor: UIColor.clear)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(title: String) {
        self.confirmButton.setTitle(title, for: .normal)
    }

    @IBAction func adPreviewAction(_ sender: Any) {
        self.delegate?.didConfirm(self)
    }
}
