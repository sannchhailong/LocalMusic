//
//  LibraryItem.swift
//  Music
//
//  Created by Sann Chhailong on 13/3/22.
//

import Foundation


struct LibraryItem: Identifiable, Decodable, Encodable {
    let id = UUID().uuidString
    let icon: String
    let title: String
    private enum CodingKeys: String, CodingKey {
        case icon, title
    }
}
