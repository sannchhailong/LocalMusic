//
//  Song.swift
//  Music
//
//  Created by Sann Chhailong on 17/3/22.
//

import Foundation
import UIKit

struct Song: Decodable, Encodable {
            
      let assetUrl: String
      let title: String
      let album: String
      let artwork: Artwork?
      let artist: String
      let genre: String
      let year: String
      private enum CodingKeys: String, CodingKey {
          case title, album, artwork, year, genre, artist
          case assetUrl = "asset_url"
      }
}

struct Artwork: Decodable, Encodable {
      let imageData: Data?
      
      private enum CodingKeys: String, CodingKey {
            case imageData = "image_data"
      }
}
