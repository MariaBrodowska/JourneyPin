//
//  MapView.swift
//  journeypin
//
//  Created by maria on 14/06/2025.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @Binding var pinTitle: String
    @Binding var selectedImageName: String?
    @Binding var selectedLat: Double?
    @Binding var selectedLon: Double?
    @Binding var isDone: Bool
    
    @State private var region: MKCoordinateRegion
    init(
        coordinate: CLLocationCoordinate2D,
               selectedLat: Binding<Double?>,
               selectedLon: Binding<Double?>,
               pinTitle: Binding<String>,
               selectedImageName: Binding<String?>,
               isDone: Binding<Bool>
    ) {
        self._pinTitle = pinTitle
        self._selectedImageName = selectedImageName
        self._selectedLat = selectedLat
        self._selectedLon = selectedLon
        self._isDone = isDone

        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        _region = State(initialValue: region)
    }
    
    let imageOptions = ["photo1", "photo2", "photo3"]
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: [Location(coordinate: region.center)]) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack(spacing: 4) {
                        Text(pinTitle)
                            .font(.caption)
                            .padding(4)
                            .background(.white)
                            .cornerRadius(5)
                        
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                    }
                    .offset(y: -30)
                }
            }
            
            //wspolrzedne
            VStack {
                Spacer()
                Text("📍 \(region.center.latitude), \(region.center.longitude)")
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding()
                
                TextField("Wpisz tytuł pinezki", text: $pinTitle)
                    .padding(8)
                    .background(.white)
                    .cornerRadius(10)
                    .padding()
                
                Button("Zapisz") {
                    selectedLat = region.center.latitude
                    selectedLon = region.center.longitude
//                    isDone = true
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .cornerRadius(10)
                
                HStack{
                    Picker("Wybierz zdjęcie", selection: $selectedImageName) {
                        Text("Brak").tag(String?.none)
                        ForEach(imageOptions, id: \.self) { imageName in
                            Text(imageName).tag(Optional(imageName))
                        }
                    }
                    .pickerStyle(.menu)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
                    //zdjecie
                    if let name = selectedImageName {
                        Image(name)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                            .padding(.top, 4)
                    }
                }
            }
            .padding()
        }
    }
}
