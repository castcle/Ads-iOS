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
//  AdsNibVars.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 3/2/2565 BE.
//

public struct AdsNibVars {
    // MARK: - View Controller
    public struct ViewController {
        public static let adsManager = "AdsManagerViewController"
        public static let createAds = "CreateAdsViewController"
        public static let selectAdsPage = "SelectAdsPageViewController"
        public static let selectAdsObjective = "SelectAdsObjectiveViewController"
        public static let selectAdsPayment = "SelectAdsPaymentViewController"
        public static let selectDailyBidType = "SelectDailyBidTypeViewController"
        public static let adsPreview = "AdsPreviewViewController"
        public static let adsDetail = "AdsDetailViewController"
    }

    // MARK: - View
    public struct Storyboard {
        public static let ads = "Ads"
    }

    // MARK: - TableViewCell
    public struct TableViewCell {
        public static let adsBudget = "AdsBudgetTableViewCell"
        public static let adsNoHistory = "AdsNoHistoryTableViewCell"
        public static let adsHistory = "AdsHistoryTableViewCell"
        public static let adsHistoryFooter = "AdsHistoryFooterTableViewCell"
        public static let choosePage = "ChoosePageTableViewCell"
        public static let chooseObjective = "ChooseObjectiveTableViewCell"
        public static let campaignName = "CampaignNameTableViewCell"
        public static let boostMessage = "BoostMessageTableViewCell"
        public static let dailyBudget = "DailyBudgetTableViewCell"
        public static let duration = "DurationTableViewCell"
        public static let adPreview = "AdPreviewTableViewCell"
        public static let selectPageHeader = "SelectPageHeaderTableViewCell"
        public static let selectPageAds = "SelectPageAdsTableViewCell"
        public static let selectObjective = "SelectObjectiveTableViewCell"
        public static let selectAdsPaymentMethod = "SelectAdsPaymentMethodTableViewCell"
        public static let confirmButton = "ConfirmButtonTableViewCell"
        public static let adsPaymentMethod = "AdsPaymentMethodTableViewCell"
        public static let dailyBid = "DailyBidTableViewCell"
        public static let dailyBidAuto = "DailyBidAutoTableViewCell"
        public static let dailyBidCostPerAccount = "DailyBidCostPerAccountTableViewCell"
        public static let adsInfoName = "AdsInfoNameTableViewCell"
        public static let adsInfoStatus = "AdsInfoStatusTableViewCell"
        public static let adsInfoBadget = "AdsInfoBadgetTableViewCell"
        public static let adsInfoDate = "AdsInfoDateTableViewCell"
        public static let adsInfoSingle = "AdsInfoSingleTableViewCell"
    }

    // MARK: - CollectionViewCell
    public struct CollectionViewCell {
        public static let tokenBalance = "TokenBalanceCollectionViewCell"
        public static let adsCredits = "AdsCreditsCollectionViewCell"
    }
}
