//
//  MapView.swift
//  journeypin
//
//  Created by maria on 14/06/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
       @Environment(\.dismiss) var dismiss
    @Binding var selectedLocation: CLLocationCoordinate2D?
        @Binding var locationName: String

       var body: some View {
           NavigationStack {
               VStack {
                   Map()
                   Spacer()
               }
               .navigationTitle("Wybierz pinezkę")
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                   ToolbarItem(placement: .navigationBarLeading) {
                       Button("Anuluj") {
                           dismiss()
                       }
                   }
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button("Zapisz") {
                           dismiss()
                       }
                   }
               }
           }
       }
}
