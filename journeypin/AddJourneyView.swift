//
//  AddJourneyView.swift
//  journeypin
//
//  Created by maria on 14/06/2025.
//

import SwiftUI
import CoreLocation

struct PinData: Identifiable {
    var id = UUID()
    var lat: Double
    var lon: Double
    var title: String
    var imageName: String?
}

struct AddJourneyView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var user: User
    @Environment(\.dismiss) var dismiss

    @State var tripName: String = ""
    @State var tripDate: Date = Date()
    @State var tripNotes: String = ""
    @State private var pins: [PinData] = []
    @State private var isDone: Bool = false
    @State var showMapView: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Section(header: Text("Szczegóły podróży").font(.title2)) {
                TextField("Nazwa podróży", text: $tripName)
                DatePicker("Data podróży", selection: $tripDate, displayedComponents: .date)
                TextField("Notatki z podróży", text: $tripNotes)
                    .frame(height: 150, alignment: .top)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
            }

            Spacer().frame(height: 40)

            Section(header: Text("Lokalizacja").font(.title2)) {
                VStack(alignment: .leading) {
                    Divider()
                    ForEach(pins.indices, id: \.self) { index in
                        let pin = pins[index]
                        HStack {
                            VStack(alignment: .leading) {
                                let pinTitle = pin.title.isEmpty ? "📍 \(pin.lat), \(pin.lon)" : pin.title
                                Text(pinTitle)
                                    .font(.subheadline)

                                if let name = pin.imageName {
                                    Text(name)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                        }
                        Divider()
                    }


                    HStack {
                        Spacer()
                        Button("Dodaj nową pinezkę") {
                            showMapView.toggle()
                        }
                        .frame(maxWidth: 200)
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
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
                    let newTrip = Trip(context: viewContext)
                    newTrip.tripname = tripName
                    newTrip.date = tripDate
                    newTrip.notes = tripNotes
                    newTrip.tripuser = user

                    for pinData in pins {
                        let pin = Pin(context: viewContext)
                        pin.lat = pinData.lat
                        pin.lon = pinData.lon
                        pin.name = pinData.title
                        pin.pintrip = newTrip
                        pin.photo = pinData.imageName
                        newTrip.addToTrippin(pin)
                    }
                    user.addToUsertrip(newTrip)
                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print("Błąd zapisu: \(error.localizedDescription)")
                    }
                }
                .disabled(tripName.isEmpty)
            }
        }
        .sheet(isPresented: $showMapView) {
            AddLocation(
                tempPins: $pins,
                isDone: $isDone
            )
        }
        .onChange(of: isDone) { done in
            if done {
                showMapView = false
                isDone = false
                print("journey view \(pins.count)")
            }
        }
    }
}
