//
//  News.swift
//  Navigation
//
//  Created by User on 16.05.2022.
//

struct News: Decodable {

    struct Post: Decodable {
        let author, description, image: String
        let likes: Int
        let views: Int

        enum CodingKeys: String, CodingKey {
                case author, description, image, likes, views
            }
    }


    let posts: [Post]
}

