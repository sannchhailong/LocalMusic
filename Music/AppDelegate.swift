//
//  AppDelegate.swift
//  Music
//
//  Created by Sann Chhailong on 22/2/22.
//

import UIKit
import AVFoundation
import MediaPlayer

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var audioPlayer: AVAudioPlayer?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback,
                                         mode: .default,
                                         policy: .default,
                                         options: [])
            try audioSession.setActive(true)
            print("Session is Active")
            
        } catch {
            print(error.localizedDescription)
        }
        UITabBar.appearance().tintColor = .accentColor
//        UITabBar.appearance().isHidden =  true
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { [unowned self] event in
            if !(self.audioPlayer?.isPlaying ?? false) {
                NotificationCenter.default.post(name: .playTrack, object: nil, userInfo: nil)
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.audioPlayer?.isPlaying ?? false {
                NotificationCenter.default.post(name: .pauseTrack, object: nil, userInfo: nil)
                return .success
            }
            return .commandFailed
        }
        commandCenter.stopCommand.addTarget { [unowned self] event in
            if self.audioPlayer?.isPlaying ?? false {
                NotificationCenter.default.post(name: .pauseTrack, object: nil, userInfo: nil)
                return .success
            }
            return .commandFailed
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(musicPlay(notification:)), name: .playTrack, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(musicPause(notification:)), name: .pauseTrack, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(musicStop(notification:)), name: .stopTrack, object: nil)

        return true
    }
    
    // MARK: listen to play_track event
    
    @objc func musicPlay(notification: NSNotification) {
        if let song = notification.object as? Song {
                do {
                    
                    self.audioPlayer = try AVAudioPlayer(contentsOf: URL(string: song.assetUrl)!)
                    self.audioPlayer?.prepareToPlay()
                    self.audioPlayer?.play()
                    var nowPlayingInfo = [String : Any]()
                    nowPlayingInfo[MPMediaItemPropertyTitle] = song.title
                    nowPlayingInfo[MPMediaItemPropertyArtist] = song.artist
                    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.audioPlayer?.currentTime
                    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.audioPlayer?.duration
                    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.audioPlayer?.rate
                    if let data = song.artwork?.imageData,let image = UIImage(data: data) {
                        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                            return image
                        }
                    } else {
                        let image: UIImage = .defaultAlbumImage
                        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                            return image
                        }
                    }
                    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
                    
                    
                } catch {
                    // couldn't load file :(
                    print("Could not load file!!! \(error.localizedDescription)")
                }
           
        } else {
            if !(audioPlayer?.isPlaying ?? false) {
                audioPlayer?.play()
            }
        }
    }
    
    @objc func musicPause(notification: NSNotification) {
        if audioPlayer?.isPlaying  ?? false {
            audioPlayer?.pause()
        }
    }
    
    @objc func musicStop(notification: NSNotification) {
        if audioPlayer?.isPlaying  ?? false {
            audioPlayer?.stop()
        }
    }
    
    
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

