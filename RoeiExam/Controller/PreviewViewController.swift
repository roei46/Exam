//
//  PreviewViewController.swift
//  RoeiExam
//
//  Created by roei baruch on 09/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class PreviewViewController: UIViewController {

    var hud: MBProgressHUD = MBProgressHUD()

    @IBOutlet weak var imageView: UIImageView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Preview"

        guard let url = self.url else { return }

        hud = MBProgressHUD.showAdded(to: self.imageView, animated: true)
        imageView.sd_setImage(with: URL(string: url)) { (image, err, type, url) in
            self.hud.hide(animated: true)
        }

    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        let imageToShare = [ imageView.image ]
        let ac = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        present(ac, animated: true)
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
}
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
