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
    var state: State = .none

    public init() {
        self.tokenHelper.delegate = self
    }

    func getAds() {
        self.state = .getAds
        self.adsRepository.getAds(adsRequest: self.adsRequest) { (success, response, isRefreshToken) in
            if success {
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    let adsData = (json[JsonKey.payload.rawValue].arrayValue).map { Ads(json: $0) }
                    self.ads.append(contentsOf: adsData)
                    self.meta = Meta(json: JSON(json[JsonKey.meta.rawValue].dictionaryValue))
                    let includes = JSON(json[JsonKey.includes.rawValue].dictionaryValue)
                    let users = includes[JsonKey.users.rawValue].arrayValue
                    UserHelper.shared.updateAuthorRef(users: users)
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
