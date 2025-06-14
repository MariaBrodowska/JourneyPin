//
//  JourneyListView.swift
//  journeypin
//
//  Created by maria on 14/06/2025.
//

import SwiftUI
import CoreData

struct JourneyListView: View {
    @State var showAdd: Bool = false;
    @EnvironmentObject var currentUser: User;
    @State var travels: [String] = [
            "Wycieczka do Włoch",
            "Wypad w góry"
    ]
    
    var body: some View {
        NavigationStack {
            ForEach(travels, id: \.self) { travel in
                        Text(travel)
                    }
            .navigationTitle("Podróże")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: AddJourneyView().environmentObject(currentUser)) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
    }
}
