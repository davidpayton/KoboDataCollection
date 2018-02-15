//
//  WorkViewController.swift
//  Kobo
//
//  Created by KobeBryant on 11/24/17.
//  Copyright © 2017 KobeBryant. All rights reserved.
//

import UIKit
import SVProgressHUD
class WorkViewController: UIViewController ,UIWebViewDelegate{

    @IBOutlet weak var workWebview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.workWebview.loadRequest(URLRequest(url: URL(string: "https://kf.kobotoolbox.org/forms/accounts/login/?next=/forms/")!))
        
        self.workWebview.delegate = self
        let url = URL(string: "https://kf.kobotoolbox.org/forms/#/forms")
        if let unwrappedURL = url{
            let request =  URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    DispatchQueue.main.async(execute: {
                        
                        UIApplication.shared.registerForRemoteNotifications()
                        self.workWebview.loadRequest(request)
                        SVProgressHUD.show(withStatus: "Loading...")
                    })
                    
                    
                }
                else{
                    print("Error:\(String(describing: error))")
                }
            }
            task.resume()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
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
