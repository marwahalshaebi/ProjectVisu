//
//  SoundEffectsModel.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-04-13.
//

// MARK: Sound effects player class

import Foundation
import AVKit

// Audio video kit needed to play sounds and videos
class SoundEffectsModel {
    static let instance = SoundEffectsModel()
    var player: AVAudioPlayer?
    
    enum SoundEffects: String{
        case meow
        case tick
    }
    
    // MARK: see https://readforlearn.com/how-to-play-a-sound-using-swift/ for code refernce and inspo
    func play(sound: SoundEffects){
        
        do{
            guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch let error {
            print("Error: Cannot play sound, \(error.localizedDescription)")
        }
    }
}
