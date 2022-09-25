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
//  AdDetailViewModel.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 26/8/2565 BE.
//

import Core
import Networking
import SwiftyJSON

public enum AdsDetailType {
    case information
    case report
    case adSetting
}

public final class AdDetailViewModel {
    enum AdsDetailSection {
        case content
        case campaignName
        case boostStatus
        case dateCteate
        case budget
        case startAndEndDate
        case budgetSpent
        case impression
        case cmp
        case report
        case status
        case page
        case objective
        case campaignNameSetting
        case campaignMessage
        case dailyBudget
        case duration
        case paymentMethod
        case cancel
    }

    private var adsRepository: AdsRepository = AdsRepositoryImpl()
    var adsDetailType: AdsDetailType = .information
    var ads: Ads = Ads()
    let tokenHelper: TokenHelper = TokenHelper()
    var state: State = .none
    var adsDetailSection: [AdsDetailSection] {
        if self.adsDetailType == .information {
            return [.content, .campaignName, .boostStatus, .dateCteate, .budget, .startAndEndDate, .budgetSpent, .impression, .cmp]
        } else if self.adsDetailType == .report {
            return [.report]
        } else {
            var section: [AdsDetailSection] = [.status, .page, .objective, .campaignNameSetting]
            if !self.ads.campaignMessage.isEmpty {
                section.append(.campaignMessage)
            }
            section.append(contentsOf: [.dailyBudget, .duration, .paymentMethod])
            if self.ads.boostStatus == .unknown {
                section.append(.cancel)
            }
            return section
        }
    }

    public init(ads: Ads = Ads()) {
        self.ads = ads
        self.tokenHelper.delegate = self
    }

    func getAdsDetail() {
        self.state = .getAdsDetail
        self.adsRepository.getAdsDetail(adsId: self.ads.id) { (success, response, isRefreshToken) in
            if success {
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    self.ads = Ads(json: json)
                    self.didGetAdsDetailFinish?()
                } catch {
                    self.didError?()
                }
            } else {
                if isRefreshToken {
                    self.tokenHelper.refreshToken()
                } else {
                    self.didError?()
                }
            }
        }
    }

    func cancelAds() {
        self.state = .cancelAds
        self.adsRepository.cancelAds(adsId: self.ads.id) { (success, _, isRefreshToken) in
            if success {
                self.didAdsActionFinish?()
            } else {
                if isRefreshToken {
                    self.tokenHelper.refreshToken()
                } else {
                    self.didError?()
                }
            }
        }
    }

    func endAds() {
        self.state = .endAds
        self.adsRepository.endAds(adsId: self.ads.id) { (success, _, isRefreshToken) in
            if success {
                self.didAdsActionFinish?()
            } else {
                if isRefreshToken {
                    self.tokenHelper.refreshToken()
                } else {
                    self.didError?()
                }
            }
        }
    }

    func runAds() {
        self.state = .runAds
        self.adsRepository.runAds(adsId: self.ads.id) { (success, _, isRefreshToken) in
            if success {
                self.didAdsActionFinish?()
            } else {
                if isRefreshToken {
                    self.tokenHelper.refreshToken()
                } else {
                    self.didError?()
                }
            }
        }
    }

    func pauseAds() {
        self.state = .pauseAds
        self.adsRepository.pauseAds(adsId: self.ads.id) { (success, _, isRefreshToken) in
            if success {
                self.didAdsActionFinish?()
            } else {
                if isRefreshToken {
                    self.tokenHelper.refreshToken()
                } else {
                    self.didError?()
                }
            }
        }
    }

    var didGetAdsDetailFinish: (() -> Void)?
    var didAdsActionFinish: (() -> Void)?
    var didError: (() -> Void)?
}

extension AdDetailViewModel: TokenHelperDelegate {
    public func didRefreshTokenFinish() {
        if self.state == .getAdsDetail {
            self.getAdsDetail()
        } else if self.state == .cancelAds {
            self.cancelAds()
        }
    }
}
