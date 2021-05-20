//
//  Attraction.swift
//  TourismApp
//
//  Created by Wanja on 2021-04-02.
//  Copyright © 2021 Wanja. All rights reserved.
//

import Foundation

class Attraction: Codable {
    let id: Int
    var name: String
    var address: String
    var description: String
    var price: Int
    var website: String
    var phone: String
    var mainImage: String
    var image1: String
    var image2: String

    init(id: Int, name: String, address: String, description: String, price: Int, website: String, phone: String, mainImage: String, image1: String, image2: String) {
        self.id = id
        self.name = name
        self.address = address
        self.description = description
        self.price = price
        self.website = website
        self.phone = phone
        self.mainImage = mainImage
        self.image1 = image1
        self.image2 = image2
    }
}
