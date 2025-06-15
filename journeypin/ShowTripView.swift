//
//  ShowTripView.swift
//  journeypin
//
//  Created by mateusz on 15/06/2025.
//

import SwiftUI
import MapKit

struct ShowTripView: View {
    @ObservedObject var trip: Trip
    @State private var selectedPinIndex: Int = 0
    @State private var imageScale: CGFloat = 1.0

   

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text(trip.tripname ?? "Podróż bez nazwy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if let notes = trip.notes, !notes.isEmpty {
                        Text(notes)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                if !trip.pinArray.isEmpty {
                    let selectedPin = trip.pinArray[selectedPinIndex]
                    
                    MapViewToDisplay(coordinate: CLLocationCoordinate2D(
                        latitude: Double(selectedPin.lat),
                        longitude: Double(selectedPin.lon)
                    ))
                    .frame(height: 280)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    if let photo = selectedPin.photo, !photo.isEmpty {
                        Image(photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 180)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .scaleEffect(imageScale)
                            .onLongPressGesture(minimumDuration: 0.5){
                                imageScale = imageScale == 1.0 ? 1.5 : 1.0
                            }
                            .onTapGesture(count : 2) {
                            
                            selectedPinIndex = (selectedPinIndex + 1) % trip.pinArray.count
                                    }
                                }
                        
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                            Text(selectedPin.name ?? "Brak nazwy")
                                .font(.headline)
                            Spacer()
                        }
                        
                       
                    }
                    .padding()
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
                    if trip.pinArray.count > 1 {
                        VStack(spacing: 8) {
                            Text("Lokalizacja \(selectedPinIndex + 1) z \(trip.pinArray.count)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Picker("Wybierz pin", selection: $selectedPinIndex) {
                                ForEach(0..<trip.pinArray.count, id: \.self) { index in
                                    Text(trip.pinArray[index].name ?? "Pin \(index + 1)")
                                        .tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding(.horizontal)
                    }
                    
                } else {
                    VStack(spacing: 16) {
                        Image(systemName: "mappin.slash")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("Brak lokalizacji")
                            .font(.headline)
                        
                        Text("Ta wycieczka nie ma jeszcze pinów.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 40)
                }
            }
            .padding(.bottom)
        }
       
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditJourneyView(trip: trip)) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
}
