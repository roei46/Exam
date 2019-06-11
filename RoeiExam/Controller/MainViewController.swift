//
//  ViewController.swift
//  RoeiExam
//
//  Created by roei baruch on 06/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = MainViewModel()
    
    @IBOutlet weak var playStopBtn: UIButton!
    @IBOutlet weak var serachTextField: UITextField!
    
    var isGettingRandom = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome!!!"
        //Disabled cach to show gif in the preview VC
        SDImageCache.shared.config.shouldCacheImagesInMemory = false
        
        getRandom()
        
        viewModel.playSound()
        playStopBtn.setTitle("Stop", for: .normal)
    }
    
    func getRandom() {
        SVProgressHUD.show()
        isGettingRandom = true
        viewModel.getRandomData(succses: {
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) {
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func playStopMusic(_ sender: Any) {
        if viewModel.isPlaying {
            playStopBtn.setTitle("Play", for: .normal)
            viewModel.stopSound()
        } else {
            playStopBtn.setTitle("Stop", for: .normal)
            viewModel.playSound()
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        viewModel.didCameFromSearch = true
        search()
    }
    
    func search() {
        SVProgressHUD.show()
        self.isGettingRandom = false
        self.view.endEditing(true)
        guard let text = serachTextField.text else { return }
        let newText = text.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        viewModel.getData(text: newText, succses: {
            if self.viewModel.count > 0 && self.viewModel.didCameFromSearch {
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
                SVProgressHUD.dismiss()
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }) {
            SVProgressHUD.dismiss()
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GifTableViewCell.reuseIdentifier, for: indexPath) as? GifTableViewCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isGettingRandom {
            if indexPath.row == viewModel.count - 1 {
                viewModel.didCameFromSearch = false
                search()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "preview") as! PreviewViewController
        newViewController.url = cellViewModel?.url
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
