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
//  AdsBudgetTableViewCell.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 3/2/2565 BE.
//

import UIKit
import Core
import CenteredCollectionView

class AdsBudgetTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    let cellPercentWidth: CGFloat = 0.9
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pageControl.backgroundColor = .clear
        self.pageControl.pageIndicatorTintColor = UIColor.Asset.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.Asset.lightBlue
        
        self.centeredCollectionViewFlowLayout = self.collectionView.collectionViewLayout as? CenteredCollectionViewFlowLayout
        self.collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: AdsNibVars.CollectionViewCell.tokenBalance, bundle: ConfigBundle.ads), forCellWithReuseIdentifier: AdsNibVars.CollectionViewCell.tokenBalance)
        self.collectionView.register(UINib(nibName: AdsNibVars.CollectionViewCell.adsCredits, bundle: ConfigBundle.ads), forCellWithReuseIdentifier: AdsNibVars.CollectionViewCell.adsCredits)
        self.centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width * cellPercentWidth,
            height: 180
        )
        self.centeredCollectionViewFlowLayout.minimumLineSpacing = 10
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension AdsBudgetTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsNibVars.CollectionViewCell.tokenBalance, for: indexPath as IndexPath) as? TokenBalanceCollectionViewCell
            return cell ?? TokenBalanceCollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsNibVars.CollectionViewCell.adsCredits, for: indexPath as IndexPath) as? AdsCreditsCollectionViewCell
            return cell ?? AdsCreditsCollectionViewCell()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let index = self.centeredCollectionViewFlowLayout.currentCenteredPage {
            self.pageControl.currentPage = index
        }
    }
}
