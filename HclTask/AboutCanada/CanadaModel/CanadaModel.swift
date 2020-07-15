//
//  CanadaModel.swift
//  HclTask
//
//  Created by Anand Sakthivel on 15/07/20.
//  Copyright © 2020 Anand Sakthivel. All rights reserved.
//

import Foundation

struct CanadaDetails: Codable {
    var title: String?
    var rows:[row]?
    
    //CodingKeys
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rows = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        rows = try values.decode([row].self, forKey: .rows)
    }
    
    struct row:Codable {
        var title: String?
        var description: String?
        var imageHref: String?
    }
}
