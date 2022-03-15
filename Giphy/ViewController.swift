//
//  ViewController.swift
//  Giphy
//
//  Created by macbook  on 08/03/22.
//

import UIKit
import GiphyUISDK


class ViewController: UIViewController,GiphyDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let giphy = GiphyViewController()
        giphy.mediaTypeConfig = [.gifs, .stickers, .text, .emoji]
        giphy.mediaTypeConfig = [.gifs, .stickers, .recents]
        giphy.theme = GPHTheme(type: .lightBlur)
        GiphyViewController.trayHeightMultiplier = 1
        //DispatchQueue.main.async { [weak self] in
        
//        self.view.addSubview(giphy.view)
            self.present(giphy, animated: true, completion: nil)
        //}
    }

    func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia)   {
       
            // your user tapped a GIF!
            giphyViewController.dismiss(animated: true, completion: nil)
       }
       
       func didDismiss(controller: GiphyViewController?) {
            // your user dismissed the controller without selecting a GIF.
       }
}

