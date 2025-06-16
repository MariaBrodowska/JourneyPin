import SwiftUI
import MapKit

struct AddLocation: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @Binding var tempPins: [PinData]
    
    @State var selectedLat: Double?
    @State var selectedLon: Double?
    @State var pinTitle: String = ""
    @State var selectedImageName: String?
    @Binding var isDone: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                MapView(
                    coordinate: CLLocationCoordinate2D(
                        latitude: selectedLat ?? 51.234667,
                        longitude: selectedLon ?? 22.550164
                    ),
                    selectedLat: $selectedLat,
                    selectedLon: $selectedLon,
                    pinTitle: $pinTitle,
                    selectedImageName: $selectedImageName
                )
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
                        guard let lat = selectedLat, let lon = selectedLon else {
                            print("Brak współrzędnych!")
                            return
                        }

                        let newPin = PinData(lat: lat, lon: lon, title: pinTitle, imageName: selectedImageName)
                        tempPins.append(newPin)
                        isDone = true
                        dismiss()
                    }
                    .disabled(selectedLat == nil || selectedLon == nil)
                }

            }

        }
    }
}
