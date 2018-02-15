//
//  AboutViewController.swift
//  Kobo
//
//  Created by KobeBryant on 11/24/17.
//  Copyright © 2017 KobeBryant. All rights reserved.
//
import AVKit
import AVFoundation
import UIKit

class AboutViewController: UIViewController {

  
    

    @IBOutlet weak var videoPlayer: UIView!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle.main
        let moviePath: String? = bundle.path(forResource: "About", ofType: "mp4")
        let movieURL = URL(fileURLWithPath: moviePath!)
//        let videoURL = URL(string: "https://youtu.be/4PNtT51h3CQ")
        player = AVPlayer(url: movieURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        self.videoPlayer.layer.addSublayer(playerLayer)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = self.videoPlayer.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
