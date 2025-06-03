//
//  HomePageView.swift
//  journeypin
//
//  Created by Al Sneed on 03/06/2025.
//

import SwiftUI

// This is a placeholder for where "Your Journeys" will navigate to.
// You'll replace this with your actual Journeys List view.
struct JourneysListView: View {
    var body: some View {
        Text("Your Journeys List Will Appear Here")
            .navigationTitle("My Journeys") // Example title for the next screen
    }
}

struct HomePageView: View {

    // Placeholder function for "Switch user" logic
    private func handleSwitchUser() {
        print("Switch User button tapped. Implement user switching logic here.")
    }

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

                                Text("Photo saving redefined")
                                    .font(.title3)
                                    .foregroundColor(.white.opacity(0.85))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }

                            Spacer()

                            
                            VStack(spacing: 20) {
                                
                                NavigationLink(destination: JourneysListView()) {
                                    Text("Your Journeys")
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: 200)
                                        .padding()
                                        .background(Color.teal)
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                }

                                
                                Button(action: handleSwitchUser) {
                                    Text("Switch User")
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: 200)
                                        .padding()
                                        .background()
                                        .foregroundColor(.accentColor)
                                        .cornerRadius(20)
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

// MARK: - Preview
struct FrontPageView_Previews: PreviewProvider {
    static var previews:	 some View {
        HomePageView()
        HomePageView()
            .preferredColorScheme(.dark) // Also preview in dark mode
    }
}
