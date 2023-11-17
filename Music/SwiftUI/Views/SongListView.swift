//
//  SongListView.swift
//  Music
//
//  Created by Chhailong on 17/11/23.
//

import SwiftUI

struct SongListView: View {
    
    @State var songs: [Song] = []
    var body: some View {
        List {
            ForEach(songs) { song in
                SongListItemView(song: song)
                    .listRowInsets(.init(top: 4, leading: 16, bottom: 4, trailing: 16))
                    .overlay {
                        Button {
                            NotificationCenter.default.post(name: .playTrack, object: song)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)
                    }
            }
        }
        .listStyle(.plain)
        .onAppear {
            if self.songs.isEmpty {
                Task {
                    AssetsLoader.shared.loadAllTracks{ tracks, error in
                        if let tracks = tracks {
                            self.songs = tracks
                            
                        }
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

struct SongListItemView: View {
    let song: Song
    var body: some View {
        HStack(spacing: 16) {
            if let imageData = song.artwork?.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 46, height: 46)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            } else {
                Image("logo")
                    .resizable()
                    .frame(width: 46, height: 46)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(song.title)
                    .font(.callout)
                    .lineLimit(1)
                Text(song.artist)
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .lineLimit(1)
                
            }
        }
    }
}

#Preview {
    SongListView()
}
