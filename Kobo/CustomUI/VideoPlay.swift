//
//  VideoPlay.swift
//  Kobo
//
//  Created by KobeBryant on 11/24/17.
//  Copyright © 2017 KobeBryant. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlay: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    class VideoPlay: UIView {
        
        private var player : AVPlayer!
        
        private var playerLayer : AVPlayerLayer!
        
        init() {
            
            super.init(frame: CGRect)
            self.initializePlayerLayer()
            
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.initializePlayerLayer()
            self.autoresizesSubviews = false
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.initializePlayerLayer()
            
        }
        
        
        private func initializePlayerLayer() {
            
            playerLayer = AVPlayerLayer()
            playerLayer.backgroundColor = UIColor.white.cgColor
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.bounds
        }
        
        func playVideoWithURL(url: NSURL) {
            
            player = AVPlayer(url: url as URL)
            player.isMuted = false
            
            playerLayer.player = player
            
            player.play()
            
            loopVideo(videoPlayer: player)
        }
        
        func toggleMute() {
            player.isMuted = !player.isMuted
        }
        
        func isMuted() -> Bool
        {
            return player.isMuted
        }
        
        func loopVideo(videoPlayer: AVPlayer) {
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
                
                videoPlayer.seek(to: kCMTimeZero)
                videoPlayer.play()
            }
        }
        
    }
}
