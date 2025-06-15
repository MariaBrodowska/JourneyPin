//
//  AddLocation.swift
//  journeypin
//
//  Created by maria on 15/06/2025.
//

import SwiftUI
import MapKit

struct AddLocation: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                MapView(coordinate: CLLocationCoordinate2D(latitude: 51.234667, longitude: 22.550164))
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
