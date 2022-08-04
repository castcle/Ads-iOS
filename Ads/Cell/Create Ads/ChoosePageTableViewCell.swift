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
//  ChoosePageTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 17/2/2565 BE.
//

import UIKit
import Core
import Kingfisher

protocol ChoosePageTableViewCellDelegate: AnyObject {
    func didChoosePage(_ cell: ChoosePageTableViewCell)
}

class ChoosePageTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var displayNameLabel: UILabel!
    @IBOutlet var castcleIdLabel: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var verifyImage: UIImageView!
    @IBOutlet var nextImage: UIImageView!
    @IBOutlet var line1View: UIView!
    @IBOutlet var line2View: UIView!

    var delegate: ChoosePageTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImage.circle(color: UIColor.Asset.white)
        self.titleLabel.font = UIFont.asset(.bold, fontSize: .body)
        self.titleLabel.textColor = UIColor.Asset.white
        self.displayNameLabel.font = UIFont.asset(.regular, fontSize: .body)
        self.displayNameLabel.textColor = UIColor.Asset.white
        self.castcleIdLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.castcleIdLabel.textColor = UIColor.Asset.white
        self.verifyImage.image = UIImage.init(icon: .castcle(.verify), size: CGSize(width: 15, height: 15), textColor: UIColor.Asset.lightBlue)
        self.line1View.backgroundColor = UIColor.Asset.cellBackground
        self.line2View.backgroundColor = UIColor.Asset.cellBackground
        self.nextImage.image = UIImage.init(icon: .castcle(.next), size: CGSize(width: 25, height: 25), textColor: UIColor.Asset.white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func configCell(page: Page) {
        let userAvatar = URL(string: page.avatar)
        self.avatarImage.kf.setImage(with: userAvatar, placeholder: UIImage.Asset.userPlaceholder, options: [.transition(.fade(0.35))])
        self.displayNameLabel.text = page.displayName
        self.castcleIdLabel.text = page.castcleId
        if page.official {
            self.verifyImage.isHidden = false
        } else {
            self.verifyImage.isHidden = true
        }
    }

    @IBAction func choosePageAction(_ sender: Any) {
        self.delegate?.didChoosePage(self)
    }
}
