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
//  AdsManagerViewModel.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 15/2/2565 BE.
//

import Core
import Networking
import SwiftyJSON

public final class AdsManagerViewModel {
    private var adsRepository: AdsRepository = AdsRepositoryImpl()
    let tokenHelper: TokenHelper = TokenHelper()
    var adsRequest: AdsRequest = AdsRequest()
    var ads: [Ads] = []
    var meta: Meta = Meta()
    var adsLoaded: Bool = false
    var adsCanLoad: Bool = true
    var state: State = .none
    var filterType: HistoryFilterType = .all

    public init() {
        self.tokenHelper.delegate = self
        self.getAds()
    }

    func getAds() {
        self.state = .getAds
        self.adsRepository.getAds(adsRequest: self.adsRequest) { (success, response, isRefreshToken) in
            if success {
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    let payload = json[JsonKey.payload.rawValue].arrayValue
                    self.meta = Meta(json: JSON(json[JsonKey.meta.rawValue].dictionaryValue))

                    if self.meta.resultCount < self.adsRequest.maxResults {
                        self.adsCanLoad = false
                    }

                    payload.forEach { ads in
                        self.ads.append(Ads(json: ads))
                    }

                    self.adsLoaded = true
                    self.didGetAdsFinish?()
                } catch {}
            } else {
                if isRefreshToken {
                    self.tokenHelper.refreshToken()
                }
            }
        }
    }

    func reloadData() {
        self.ads = []
        self.adsLoaded = false
        self.adsCanLoad = true
        self.adsRequest.maxResults = 25
        self.adsRequest.untilId = ""
        self.getAds()
    }

    var didGetAdsFinish: (() -> Void)?
}

extension AdsManagerViewModel: TokenHelperDelegate {
    public func didRefreshTokenFinish() {
        if self.state == .getAds {
            self.getAds()
        }
    }
}
