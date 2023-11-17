//
//  DateVO.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import Foundation

struct DateVO : Codable {
    let maximum : String?
    let minimum : String?
    
    enum CodingKeys: String, CodingKey {
        case maximum
        case minimum
    }
}
