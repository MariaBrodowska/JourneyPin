//
//  HomePageView.swift
//  journeypin
//
//  Created by Al Sneed on 03/06/2025.
//

import SwiftUI

// This is a placeholder for where "Your Journeys" will navigate to.
// You'll replace this with your actual Journeys List view.
//struct JourneysListView: View {
//    var body: some View {
//        Text("Your Journeys List Will Appear Here")
//            .navigationTitle("My Journeys") // Example title for the next screen
//    }
//}

struct HomePageView: View {
    @Environment(\.managedObjectContext) private var viewContext;
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)],
        predicate: NSPredicate(format: "lastActive == YES"),
        animation: .default)
    private var loggedin: FetchedResults<User>
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.container)
                VStack {
                    VStack {
                        VStack(spacing: 30) {
                            Spacer()

                            
                            VStack(spacing: 15) {
                                Image("icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.accentColor)

                                Text("JourneyPin")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.white.opacity(0.85))

                                Text("Nowy sposób na organizację wspomnień")
                                    .font(.title3)
                                    .foregroundColor(.white.opacity(0.85))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }

                            Spacer()

                            
                            VStack(spacing: 20) {
                                if(!loggedin.isEmpty) {
                                    NavigationLink(destination: JourneyListView().environmentObject(loggedin[0])) {
                                        Text("Twoje podróże")
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: 200)
                                            .padding()
                                            .background(Color.teal)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                    }
                                }
                                NavigationLink(destination: UserPickView()) {
                                    Text("Zmień profil")
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: 200)
                                        .padding()
                                        .background()
                                        .foregroundColor(.accentColor)
                                        .cornerRadius(20)
                                }
                                if(!loggedin.isEmpty) {
                                    Text("Wybrano profil: \(loggedin[0].username!)")
                                        .foregroundStyle(Color.white)
                                } else {
                                    Text("Nie wybrano profilu")
                                        .foregroundStyle(Color.white)
                                }
                            }
                            .padding(.horizontal, 40)
                            Spacer()
                        }
                    }
                    
                }
            }
        }
    }
}

