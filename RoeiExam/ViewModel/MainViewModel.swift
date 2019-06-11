//
//  MainViewModel.swift
//  RoeiExam
//
//  Created by roei baruch on 06/06/2019.
//  Copyright © 2019 roei baruch. All rights reserved.
//

import Foundation
import AVFoundation

class MainViewModel {
    
    var player: AVAudioPlayer?
    
    private let networking = Networking()
    
    private var gifs = [Gif]()
    
    var isPlaying = false
    var didCameFromSearch = false
    
    var totalResult: Int?
    var nextPageUrl: Int?
    var textFromUser: String?
    
    func getRandomData(succses: @escaping () -> Void, failure: @escaping () -> Void) {
        self.networking.preformNetwokTask(endPoint: GiphyApi.random, type: GifDataRandom.self , complition: { [weak self] (response) in
            if let result = response.data {
                self?.gifs.append(result)
                succses()
            }
        }) {
            failure()
        }
    }
    
    func getData(text: String, succses: @escaping () -> Void, failure: @escaping () -> Void) {
        if self.didCameFromSearch {
            self.resetResults()
        }
        self.networking.preformNetwokTask(endPoint: GiphyApi.search(text, nextPageUrl?.description ?? ""), type: GifData.self, complition: { [weak self] (response) in
            if self?.textFromUser == nil {
                self?.textFromUser = text
            }
            
            if text == self?.textFromUser {
                if self?.gifs.count ?? 0 <= self?.totalResult ?? 0 {
                    self?.updateModel(gifData: response, succses: {
                        succses()
                    })
                }
            } else {
                self?.resetResults()
            }
        }) {
            failure()
        }
    }
    
    private func updateModel(gifData: GifData, succses: @escaping () -> Void) {
        if let result = gifData.data {
            let merge = result + self.gifs
            self.gifs = merge
        }
        print("gif:\(String(describing: self.gifs.count))")
        self.nextPageUrl = (gifData.pagination?.offset ?? 0) + 1
        self.totalResult = gifData.pagination?.total_count
        succses()
        
    }
    
    private func resetResults() {
        self.gifs = [Gif]()
        print("resetResults\(self.gifs.count)")
        self.totalResult = 0
        self.nextPageUrl = 0
    }
    
    public func cellViewModel(index: Int) -> GifTableViewCellModel? {
        //        guard let gifs = gifs else { return nil }
        let gifTableViewCellModel = GifTableViewCellModel(gif: gifs[index])
        return gifTableViewCellModel
    }
    
    public var count: Int {
        return gifs.count 
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "ZakkWylde", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            isPlaying = true
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        if player != nil {
            player?.stop()
            isPlaying = false
            player = nil
        }
    }
}
