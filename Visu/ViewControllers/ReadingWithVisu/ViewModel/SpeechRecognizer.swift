//
//  VoiceActivationViewModel.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import AVFoundation
import Foundation
import Speech

// MARK: This class's purpose is for transcribing speech to text using SFSpeechRecognizer and AVAudioEngine. This class is referenced from Apple iOS developer documentation

class SpeechRecognizer: ObservableObject {
    // Enums helps in encapsulating use cases for error checking
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable

        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Authorization not permitted"
            case .notPermittedToRecord: return "Audio recording not permitted"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    var transcriptUpdated : ((String) -> ())?
    var transcript: String = "" {
        didSet {
            if transcript != "" {
                transcriptUpdated?(transcript)
            }
        }
    }
    
    // MARK: variables
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?

    // Initializes a new speech recognizer. If this is the first time you've used the class, it
    // requests access to the speech recognizer and the microphone.
    
    init() {
        recognizer = SFSpeechRecognizer()

        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                speakError(error)
            }
        }
    }

    deinit {
        reset()
    }

    //Begin transcribing audio. Creates a SFSpeechRecognitionTask that transcribes speech to text until you call `stopTranscribing()`.
    //The resulting transcription is continuously written
     
    func transcribe() {
        print("[Task] -- Transcription in progress")
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavailable)
                return
            }

            do {
                let (audioEngine, request) = try Self.prepareEngine()
                self.audioEngine = audioEngine
                self.request = request
                self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
            } catch {
                self.reset()
                self.speakError(error)
            }
        }
    }

    // Stop transcribtion.
    func stopTranscribing() {
        reset()
    }

    // Reset the speech recognizer engine.
    func reset() {
        print("[Task] -- Resetting engine")
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }

    // MARK: see  https://developer.apple.com/documentation/speech/recognizing_speech_in_live_audio for code refernce and inspo
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        // InputNode creates a singleton for the incoming audio.
        // Configure the microphone input.
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.removeTap(onBus: 0)
        sleep(1) // needed for system version conflicts
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()

        return (audioEngine, request)
    }

    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil

        if receivedFinalResult || receivedError {
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
        }

        if let result = result {
            speak(result.bestTranscription.formattedString)
        }
    }

    private func speak(_ message: String) {
        transcript = message
    }

    private func speakError(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        transcript = "<< \(errorMessage) >>"
    }
}

// Extensions from Apple iOS developer documentation on SFSpeech Recognizer and AVAudio Session
extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
