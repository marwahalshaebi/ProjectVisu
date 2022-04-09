//
//  VoiceDetectionActivatedView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import Firebase

struct VoiceDetectionActivatedView: View {

    @StateObject private var VAModel = VoiceActivationViewModel()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var showFailedAlert: Bool = false
    @State private var showDetailScreen: Bool = false
    @State var isRecording = false
    let uid = Auth.auth().currentUser?.uid
    var ref = Database.database().reference()
    // close view
    @Environment(\.dismiss) var dismiss


    var body: some View {
        ZStack {
            Color("green")
            NavigationLink(destination: PlayTrackView(), isActive: $showDetailScreen) {
                EmptyView()
            }
            VStack {
                Spacer()
                ZStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                        Text(VAModel.word)
                            .font(.system(size: 30))
                        VStack(alignment: .center) {
                            Text("Score: \(VAModel.score)").padding(.top,8)
                            Spacer()
                            Text("[Read the word on screen ]...").padding(.bottom,8)
                        }
                    }

                    VStack {
                        Spacer()
                        HStack {
                            Image("book")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .offset(x: -50, y: 35)
                            Spacer()
                        }
                    }
                }
                .frame(width: (Constant.screenHeight - (Constant.screenHeight * 0.4)),height: Constant.screenWidth - 150)

                Spacer()
                VisuButton(title: "END") {
                    print("end button clicked")
                    // update user's score
                    print("updating to user: \(uid!)")
                    ref.child("users/\(uid!)/readingScore").setValue(VAModel.score)
                    dismiss()
                    
                }
                .frame(width: Constant.screenWidth * 0.8)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 5, y: 5)
                .padding(.bottom,50)
            }


        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .alert("Didn't match the word, try again?", isPresented: $showFailedAlert, actions: {
            Button("No", role: .destructive, action: {})
            Button("Yes", role: .cancel, action: {
                speechRecognizer.reset()
                speechRecognizer.transcribe()
            })
        })
        .onAppear(perform: {
            print("[Task] -- Now Listening")
            speechRecognizer.reset()
            speechRecognizer.transcribe()
            bindSpeechToViewModel()
            
        })
        .onDisappear {
            speechRecognizer.stopTranscribing()
            DispatchQueue.main.async {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                UINavigationController.attemptRotationToDeviceOrientation()
            }
        }
    }

    func bindSpeechToViewModel() {
        speechRecognizer.transcriptUpdated = { word in
            DispatchQueue.main.async {
                VAModel.processedNewWord(word)
                print("[Task] -- word processed")
            }
        }
       
        VAModel.onClearSpeech = {
            speechRecognizer.transcript = ""
            speechRecognizer.reset()
            speechRecognizer.transcribe()
            
        }

        VAModel.onWrongSpeak = {
            speechRecognizer.transcript = ""
            speechRecognizer.reset()
            showFailedAlert = true
        }
    }
}

struct VoiceDetectionActivatedView_Previews: PreviewProvider {
    static var previews: some View {
        VoiceDetectionActivatedView()
.previewInterfaceOrientation(.landscapeRight)
    }
}
