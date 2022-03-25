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
//  AdsPreviewViewModel.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 23/2/2565 BE.
//

import Core
import Networking
import SwiftyJSON

public final class AdsPreviewViewModel {
    
    enum AdsPreviewSection {
        case header
        case page
        case content
        case confirm
    }
    
    private var adsRepository: AdsRepository = AdsRepositoryImpl()
    let tokenHelper: TokenHelper = TokenHelper()
    var ads: Ads = Ads()
    var page: Page = Page()
    private var adsRequest: AdsRequest = AdsRequest()
    
    var adsPreviewSection: [AdsPreviewSection] {
        if self.ads.boostType == .page {
            return [.header, .page, .confirm]
        } else {
            return [.header, .content, .confirm]
        }
    }
    
    public init(ads: Ads = Ads(), page: Page = Page()) {
        self.ads = ads
        self.page = page
        self.tokenHelper.delegate = self
    }
    
    func createAds(adsRequest: AdsRequest) {
        self.adsRequest = adsRequest
        self.adsRepository.createAds(adsRequest: self.adsRequest) { (success, response, isRefreshToken) in
            if success {
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    print(json)
                    print("========")
//                    let payload = json[ContentShelfKey.payload.rawValue].arrayValue
//                    let meta: Meta = Meta(json: JSON(json[ContentShelfKey.meta.rawValue].dictionaryValue))
//
//                    if meta.resultCount < self.adsRequest.maxResults {
//                        self.adsCanLoad = false
//                    }
//
//                    payload.forEach { ads in
//                        self.ads.append(Ads(json: ads))
//                    }
//
//                    self.meta = meta
//                    self.adsLoaded = true
//                    self.didGetAdsFinish?()
                } catch {}
            } else {
                if isRefreshToken {
                    self.tokenHelper.refreshToken()
                }
            }
        }
    }
}

extension AdsPreviewViewModel: TokenHelperDelegate {
    public func didRefreshTokenFinish() {
        self.createAds(adsRequest: self.adsRequest)
    }
}
