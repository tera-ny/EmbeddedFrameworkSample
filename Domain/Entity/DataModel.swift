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
    let facebookId: String?
    let followeesCount: Int
    let followersCount: Int
    let githubLoginName: String?
    let id: String
    let itemsCount: Int
    let linkedinId: String?
    let location: String?
    let name: String?
    let organization: String?
    let permanentId: Int?
    let profileImageUrl: String
    let teamOnly: Bool
    let twitterScreenName: String?
    let websiteUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case description
        case facebookId = "facebook_id"
        case followeesCount = "followees_count"
        case followersCount = "followers_count"
        case githubLoginName = "github_login_name"
        case id
        case itemsCount = "items_count"
        case linkedinId = "linkedin_id"
        case location
        case name
        case organization
        case permanentId = "permanent_id"
        case profileImageUrl = "profile_image_url"
        case teamOnly = "team_only"
        case twitterScreenName = "twitter_screen_name"
        case websiteUrl = "website_url"
    }
    
    func request(page: Int, per: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        let network = NetworkCreator.create()
        let model = APIModel(path: network.domain, requestMethod: .get)
        network.request(model: model) { (result) in
            guard case .success(let json) = result else {
                if case .failure(let error) = result {
                    completion(.failure(error))
                }
                return
            }
            do {
                let users = try NetworkParser.decodeToBaseDataModels(json: json, type: User.self)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

public struct Item: BaseDataModel {
    let renderedBody: String
    let body: String
    let coediting: Bool
    let commentsCount: Int
    let createdAt: String
    let group: Group?
    let id: String
    let likesCount: Int
    let isPrivate: Bool
    let reactionsCount: Int
    let tags: [Tag]
    let title: String
    let updatedAt: String
    let url: String
    let user: User
    let pageViewsCount: Int?
    private enum CodingKeys: String, CodingKey {
        case renderedBody = "rendered_body"
        case body
        case coediting
        case commentsCount = "comments_count"
        case createdAt = "created_at"
        case group
        case id
        case likesCount = "likes_count"
        case isPrivate = "private"
        case reactionsCount = "reactions_count"
        case tags
        case title
        case updatedAt = "updated_at"
        case url
        case user
        case pageViewsCount = "page_views_count"
    }
    struct Tag: Codable {
        let name: String
        let versions: [String]
    }
    struct Group: Codable {
        let createdAt: String
        let id: String
        let name: String
        let isPrivate: Bool
        let updatedAt: String
        let urlName: String
        
        private enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
            case id
            case name
            case isPrivate = "private"
            case updatedAt = "updated_at"
            case urlName = "url_name"
        }
    }
}
