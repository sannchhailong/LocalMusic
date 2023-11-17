//
//  AssetsLoader.swift
//  Music
//
//  Created by Sann Chhailong on 17/3/22.
//

import Foundation
import AVKit

enum TracksLoadingResult<Success, Failure> {
    case success(Success)
    case failure(Failure)
}

class AssetsLoader {
    static let shared = AssetsLoader()
    private let fileManager = FileManager.default

    func saveDefaultAsset() {
        
        do {
            let documentDirectory = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            if let url = Bundle.main.url(forResource: "jar_of_heart", withExtension: "mp3") {
                let data = try Data(contentsOf: url)
                try data.write(to: documentDirectory.appendingPathComponent("jar_of_heart.mp3"))
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func loadAllTracks(_ handler: @escaping ([Song]?,Error?) -> (Void)) {
        
        var songs = [Song]()
        
        do {
            let documentDirectory = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: documentDirectory,
                includingPropertiesForKeys: nil
            )
            
            
            for url in directoryContents {
                if url.isMP3 {
                    let asset = AVAsset(url: url)
                    if let format = asset.availableMetadataFormats.first {
                        var artist = ""
                        var album = ""
                        var title = ""
                        var genre = ""
                        var year = ""
                        var imageData = Data()
                        for metadata in asset.metadata(forFormat: format) {
                            
                            if metadata.commonKey == .commonKeyArtist {
                                artist = metadata.stringValue ?? "Unknown Artist"
                            }
                            if metadata.commonKey == .commonKeyAlbumName {
                                album = metadata.stringValue ?? "Unknown Album"
                            }
                            
                            if metadata.commonKey == .commonKeyTitle {
                                title = metadata.stringValue ?? "Unknown Title"
                            }
                            
                            if metadata.commonKey == .quickTimeMetadataKeyGenre {
                                genre = metadata.stringValue ?? ""
                            }
                            
                            if metadata.commonKey == .id3MetadataKeyOriginalReleaseYear {
                                year = metadata.stringValue ?? ""
                            }
                            
                            if let data = metadata.dataValue {
                                imageData = data
                            }
                        }
                        let song = Song(
                            assetUrl: url.absoluteString,
                            title: title,
                            album: album,
                            artwork: Artwork(imageData: imageData),
                            artist: artist,
                            genre: genre,
                            year: year)
                        
                        songs.append(song)
                    } else {
                        let song = Song(
                            assetUrl: url.absoluteString,
                            title: "unknown",
                            album: "unknown",
                            artwork: nil,
                            artist: "unknown",
                            genre: "unknown",
                            year: "unknown")
                        
                        songs.append(song)
                    }
                }
            }
            handler(songs,nil)
        } catch {
            print(error)
            handler(nil,error)
        }
        
    }
}

extension URL {
    var typeIdentifier: String? { (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier }
    var isMP3: Bool { typeIdentifier == "public.mp3" }
    var localizedName: String? { (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName }
    var hasHiddenExtension: Bool {
        get { (try? resourceValues(forKeys: [.hasHiddenExtensionKey]))?.hasHiddenExtension == true }
        set {
            var resourceValues = URLResourceValues()
            resourceValues.hasHiddenExtension = newValue
            try? setResourceValues(resourceValues)
        }
    }
}
//org.xiph.flac,com.microsoft.waveform-audio
extension Encodable {

    /// Converting object to postable dictionary
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any]? {
        do {
            let data = try encoder.encode(self)
            let object = try JSONSerialization.jsonObject(with: data)
            guard let json = object as? [String: Any] else {
                let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
                throw DecodingError.typeMismatch(type(of: object), context)
            }
            return json
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
