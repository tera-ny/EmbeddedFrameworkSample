//
//  BaseDataModel.swift
//  Domain
//
//  Created by haruta yamada on 2019/03/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

public protocol BaseDataModel: Codable {}

public struct User: BaseDataModel {
    let description: String?
    let facebook_id: String?
    let followees_count: Int
    let followers_count: Int
    let github_login_name: String?
    let id: String
    let items_count: Int
    let linkedin_id: String?
    let location: String?
    let name: String?
    let organization: String?
    let permanent_id: Int?
    let profile_image_url: String
    let team_only: Bool
    let twitter_screen_name: String?
    let website_url: String?
}
