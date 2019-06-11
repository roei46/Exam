//
//  GifTableViewCell.swift
//  RoeiExam
//
//  Created by roei baruch on 07/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import UIKit
import SDWebImage

class GifTableViewCell: UITableViewCell {

    public static let reuseIdentifier = "Cell"

    @IBOutlet weak var sourceLbl: UILabel!
    
    @IBOutlet weak var imageViewGif: UIImageView!
    

    public var viewModel: GifTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.sourceLbl.text = viewModel.source

            imageViewGif.sd_setImage(with: URL(string: viewModel.url)) { [weak self] (image, err, type, url) in
                
                if err != nil {
                    print("sd_setImage\(String(describing: err))")
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
