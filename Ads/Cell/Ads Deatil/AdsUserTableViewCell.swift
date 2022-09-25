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
//  AdsUserTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 24/9/2565 BE.
//

import UIKit
import Core
import Networking
import Kingfisher

class AdsUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userContentView: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var castcleIdLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.displayNameLabel.font = UIFont.asset(.bold, fontSize: .overline)
        self.displayNameLabel.textColor = UIColor.Asset.white
        self.castcleIdLabel.font = UIFont.asset(.bold, fontSize: .small)
        self.castcleIdLabel.textColor = UIColor.Asset.gray
        self.descLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.descLabel.textColor = UIColor.Asset.white
        self.userContentView.backgroundColor = UIColor.Asset.cellBackground
        self.avatarImage.circle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configCell(ads: Ads) {
        self.displayNameLabel.text = ads.user.displayName
        self.castcleIdLabel.text = ads.user.castcleId
        self.descLabel.text = ads.user.overview
        let userAvatar = URL(string: ads.user.images.avatar.thumbnail)
        let userCover = URL(string: ads.user.images.cover.thumbnail)
        self.avatarImage.kf.setImage(with: userAvatar, placeholder: UIImage.Asset.userPlaceholder, options: [.transition(.fade(0.35))])
        self.coverImage.kf.setImage(with: userCover, placeholder: UIImage.Asset.placeholder, options: [.transition(.fade(0.35))])
    }
}
