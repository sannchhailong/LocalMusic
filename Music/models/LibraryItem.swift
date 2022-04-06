//
//  LibraryItem.swift
//  Music
//
//  Created by Sann Chhailong on 13/3/22.
//

import Foundation


struct LibraryItem: Decodable, Encodable {
    let icon: String
    let title: String
    private enum CodingKeys: String, CodingKey {
        case icon, title
    }
}
