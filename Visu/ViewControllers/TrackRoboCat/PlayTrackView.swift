//
//  PlayTrackView.swift
//  Visu
//
//  Created by Marwah Alshaebi on 2022-03-19.
//
import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import Firebase

struct PlayTrackView: View {
    
    // MARK: variables and state objects
    let widthBound = UIScreen.main.bounds.width
    let heightBound = UIScreen.main.bounds.height
    @State var randomX: CGFloat = 200.0
    @State var randomY: CGFloat = 200.0
    @State private var buttonClicked = false
    @State private var score: Int = 0
    @State private var userScore: Int = 0
    let uid = Auth.auth().currentUser?.uid
    var ref = Database.database().reference()
    
    // close view and go back
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        
        ZStack{
            Image("findRobocat")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width + 35, height: UIScreen.main.bounds.height )
            
            Image("robocat")
                .resizable()
                .frame(width: 70, height: 56)
                .position(x: randomX, y: randomY)
                .onTapGesture {
                    SoundEffectsModel.instance.play(sound: .tick)
                    self.buttonClicked.toggle()
                    // Randomize the position every time tap is clicked
                    randomX = CGFloat.random(in: 60...widthBound - 50)
                    randomY = CGFloat.random(in: 60...heightBound - 50)
                    print("new positions --> x: \(randomX) y: \(randomY)")
                    score+=1
                }
            ZStack{
                // scoring view
                Text("\(score)")
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(Color("white"))
                    .background(Color("teal"))
                    .clipped()
                    .clipShape(Circle())
                
                
            }
            .frame(width: 40, height: 40)
            .position(x: Constant.screenHeight - 50, y: 50)
            
            ZStack{
                // MARK: X MARK TO EXIT VIEW
                Button(action: {
                    print("[loading] .. exiting track exercise")
                    
                    // update user's score ONLY if it's the highest recorded score
                    
                    print("User score is: \(userScore) - Current game score is \(score)")
                    if score > userScore {
                        print("[Task] Updating to user: \(uid!)")
                        ref.child("users/\(uid!)/findRoboCatScore").setValue(score)
                    }
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(Color("white"))
                        .background(Color("black"))
                        .clipped()
                        .clipShape(Circle())
                })

                
            }
            .frame(width: 40, height: 40)
            .position(x: 65, y: 50)
            
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear(){
            SoundEffectsModel.instance.play(sound: .meow)
            // MARK: FETCH USER'S INFORMATION. SEE FIREBASE DOCUMENTATION
            
            ref.child("users").child(uid!).getData(completion: { error, snapshot in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return;
                }
                if let dictionary = snapshot.value as? [String: Any]{
                    userScore = dictionary["findRoboCatScore"] as! Int
                }
                print("fetched score \(userScore)")
            })
        }
        .onDisappear {
            DispatchQueue.main.async {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                UINavigationController.attemptRotationToDeviceOrientation()
            }
        }
        
        
    }
}

struct PlayTrackView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTrackView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
