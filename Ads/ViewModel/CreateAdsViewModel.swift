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
//  CreateAdsViewModel.swift
//  Ads
//
//  Created by Castcle Co., Ltd. on 17/2/2565 BE.
//

import Core
import Networking
import RealmSwift

public final class CreateAdsViewModel {
    var ads: Ads = Ads()
    var page: Page = Page()

    enum CreateAdsContent {
        case page
        case objective
        case campaignName
        case campaignMessage
        case dailyBudget
        case duration
        case paymentMethod
        case adPreview
    }

    var contents: [CreateAdsContent] {
        if self.ads.boostType == .content {
            return []
        } else {
            return [.page, .objective, .campaignName, .campaignMessage, .dailyBudget, .duration, .paymentMethod, .adPreview]
        }
    }

    public init() {
        do {
            let realm = try Realm()
            if let pageRealm = realm.objects(Page.self).first {
                self.page = pageRealm
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
