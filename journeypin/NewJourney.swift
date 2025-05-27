//
//  NewJourney.swift
//  journeypin
//
//  Created by maria on 27/05/2025.
//

import SwiftUI

struct NewJourney: View {
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var pin: String = "wspolrzedna"
    var body: some View {
        VStack(alignment: .leading){
            Text("Dodaj nową podróż")
            TextField(
                "Tytuł",
                text: $title
            )
            TextField(
                "Notatki",
                text: $notes
            )
            Button(action: {pin="vf"}, label: {Text("Kliknij aby dodać pinezkę")})
            Text("Dodano: \(pin)")
        }.padding()
    }
}

#Preview {
    NewJourney()
}
