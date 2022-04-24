//
//  VoiceActivationViewModel.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI
import Combine

class VoiceActivationViewModel: ObservableObject {
    // MARK: Class' Variables
    @Published var word: String = ""
    @Published var score: Int = 0
    private var words: [String] = []
    private var cancellable = Set<AnyCancellable>()
    
    // (() -> ())? a closure with no paramteres, void -> void
    var onClearSpeech: (() -> ())? = nil
    var onWrongSpeak: (() -> ())? = nil
    
    // initilize words list
    init() {
        Task {
            self.words = try await getRandomizedWordList()
            await self.reloadWord()
        }
    }

    // Generate a randoom word from words list
    private func getRandomizedWordList() async throws -> [String] {
        var wordList: [String] = []
        let fileURL = Bundle.main.url(forResource: "words", withExtension: "json")!
        let (bytes, _) = try await URLSession.shared.bytes(from: fileURL)
        for try await line in bytes.lines {
            wordList.append(line)
        }
        return wordList
    }

    private func generateRandomWord() -> String {
        return words.randomElement() ?? ""
    }

    func processedNewWord(_ message: String) {
        print("-- Listening for --- : [ \(word) ]")
        print("--- User Said --- : [ \(message) ]")
        if message.lowercased().contains(word) {
            Task {
                await reloadWord()
                print("[Task] -- Now Listening for [ \(self.word) ] ")

                
            }
            onClearSpeech?()
            score += 1
        } else {
            onWrongSpeak?()
        }
    }

    @MainActor
    func reloadWord() {
        self.word = generateRandomWord()
    }

}
