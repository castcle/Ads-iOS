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
//  AdsOpener.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 3/2/2565 BE.
//

import UIKit
import Core

public enum AdsScene {
    case adsManager
    case createAds
    case selectAdsPage(String)
    case selectAdsObjective(AdsObjective)
    case selectAdsPayment(AdsPaymentType)
    case selectDailyBidType(DailyBidType, Int)
    case adsPreview(AdsPreviewViewModel)
}

public struct AdsOpener {
    public static func open(_ adsScene: AdsScene) -> UIViewController {
        switch adsScene {
        case .adsManager:
            let storyboard: UIStoryboard = UIStoryboard(name: AdsNibVars.Storyboard.ads, bundle: ConfigBundle.ads)
            let viewController = storyboard.instantiateViewController(withIdentifier: AdsNibVars.ViewController.adsManager)
            return viewController
        case .createAds:
            let storyboard: UIStoryboard = UIStoryboard(name: AdsNibVars.Storyboard.ads, bundle: ConfigBundle.ads)
            let viewController = storyboard.instantiateViewController(withIdentifier: AdsNibVars.ViewController.createAds)
            return viewController
        case .selectAdsPage(let oldSelect):
            let storyboard: UIStoryboard = UIStoryboard(name: AdsNibVars.Storyboard.ads, bundle: ConfigBundle.ads)
            let viewController = storyboard.instantiateViewController(withIdentifier: AdsNibVars.ViewController.selectAdsPage) as? SelectAdsPageViewController
            viewController?.oldSelect = oldSelect
            return viewController ?? SelectAdsPageViewController()
        case .selectAdsObjective(let oldSelect):
            let storyboard: UIStoryboard = UIStoryboard(name: AdsNibVars.Storyboard.ads, bundle: ConfigBundle.ads)
            let viewController = storyboard.instantiateViewController(withIdentifier: AdsNibVars.ViewController.selectAdsObjective) as? SelectAdsObjectiveViewController
            viewController?.oldSelect = oldSelect
            return viewController ?? SelectAdsObjectiveViewController()
        case .selectAdsPayment(let oldSelect):
            let storyboard: UIStoryboard = UIStoryboard(name: AdsNibVars.Storyboard.ads, bundle: ConfigBundle.ads)
            let viewController = storyboard.instantiateViewController(withIdentifier: AdsNibVars.ViewController.selectAdsPayment) as? SelectAdsPaymentViewController
            viewController?.oldSelect = oldSelect
            return viewController ?? SelectAdsPaymentViewController()
        case .selectDailyBidType(let oldSelect, let cost):
            let storyboard: UIStoryboard = UIStoryboard(name: AdsNibVars.Storyboard.ads, bundle: ConfigBundle.ads)
            let viewController = storyboard.instantiateViewController(withIdentifier: AdsNibVars.ViewController.selectDailyBidType) as? SelectDailyBidTypeViewController
            viewController?.oldSelect = oldSelect
            viewController?.cost = cost
            return viewController ?? SelectDailyBidTypeViewController()
        case .adsPreview(let viewModel):
            let storyboard: UIStoryboard = UIStoryboard(name: AdsNibVars.Storyboard.ads, bundle: ConfigBundle.ads)
            let viewController = storyboard.instantiateViewController(withIdentifier: AdsNibVars.ViewController.adsPreview) as? AdsPreviewViewController
            viewController?.viewModel = viewModel
            return viewController ?? AdsPreviewViewController()
        }
    }
}
