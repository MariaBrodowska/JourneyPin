//
//  AddJourneyView.swift
//  journeypin
//
//  Created by maria on 14/06/2025.
//

import SwiftUI
import CoreLocation

struct AddJourneyView: View {
    @State var tripName: String = ""
    @State var tripDate: Date = Date()
    @State var tripNotes: String = ""
    
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var locationName: String = "Nie wybrano"
    
    @State var showMapView: Bool = false
    @EnvironmentObject var user: User
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading){
            Section(header: Text("Szczegóły podróży").font(.title2)) {
                TextField("Nazwa podróży", text: $tripName)
                DatePicker("Data podróży", selection: $tripDate, displayedComponents: .date)
                TextField("Notatki z podróży", text: $tripNotes)
                    .frame(height: 150, alignment: .top)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
            }
            Spacer()
                .frame(height: 40)
            Section(header: Text("Lokalizacja").font(.title2)) {
                HStack {
                    Text("Wybrana lokalizacja")
                        .padding(.vertical, 8)
                    Spacer()
                    Text(locationName)
                        .foregroundColor(.gray)
                }
                HStack {
                    Spacer()
                    Button("Wybierz na mapie") {
                        showMapView.toggle()
                    }
                    .frame(maxWidth: 200)
                    .padding()
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Nowa podróż")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Zapisz") {
                    print("Zapisywanie podróży: \(tripName)")
                    dismiss()
                }
                .disabled(tripName.isEmpty)
            }
        }
        .sheet(isPresented: $showMapView) {
//            MapView(selectedLocation: $selectedLocation, locationName: $locationName)
            AddLocation()
        }
    }
}
