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
    @State private var region: MKCoordinateRegion
    init(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        _region = State(initialValue: region)
    }
    
    @State private var selectedImageName: String? = nil
    let imageOptions = ["photo1", "photo2", "photo3"]

    @State private var pinTitle: String = ""

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
//            Map(coordinateRegion: $region)
//            //pinezka leeko przesunieta w gore
//            Image(systemName: "mappin.and.ellipse")
//                .font(.system(size: 40))
//                .foregroundColor(.blue)
//                .offset(y: -20)
            
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
                
//                Button("Zatwierdź lokalizację") {
//                    let wybranaLokalizacja = region.center
//                    print("Wybrano: \(wybranaLokalizacja)")
//                    // Możesz przekazać do modelu / zamknąć widok
//                }
//                .padding()
//                .background(.blue)
//                .foregroundStyle(.white)
//                .cornerRadius(10)
                
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
