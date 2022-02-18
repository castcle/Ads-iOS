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
//  DailyBudgetTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 17/2/2565 BE.
//

import UIKit
import Core

protocol DailyBudgetTableViewCellDelegate {
    func didEditChange(_ cell: DailyBudgetTableViewCell, budget: Int)
}

class DailyBudgetTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var minLabel: UILabel!
    @IBOutlet var maxLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var editIcon: UIImageView!
    
    var delegate: DailyBudgetTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.asset(.bold, fontSize: .body)
        self.titleLabel.textColor = UIColor.Asset.white
        self.amountLabel.font = UIFont.asset(.regular, fontSize: .h4)
        self.amountLabel.textColor = UIColor.Asset.white
        self.noteLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.noteLabel.textColor = UIColor.Asset.white
        self.minLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.minLabel.textColor = UIColor.Asset.white
        self.maxLabel.font = UIFont.asset(.regular, fontSize: .overline)
        self.maxLabel.textColor = UIColor.Asset.white
        self.slider.thumbTintColor = UIColor.Asset.lightBlue
        self.slider.minimumTrackTintColor = UIColor.Asset.lightBlue
        self.slider.value = 0.1
        self.editIcon.image = UIImage.init(icon: .castcle(.editNew), size: CGSize(width: 25, height: 25), textColor: UIColor.Asset.white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func sliderValueChange(_ sender: Any) {
        let value = Int(self.slider.value * 100)
        if value == 0 {
            self.amountLabel.text = "$1"
            self.delegate?.didEditChange(self, budget: 1)
        } else {
            self.amountLabel.text = "$\(Int(value))"
            self.delegate?.didEditChange(self, budget: Int(value))
        }
    }
}
