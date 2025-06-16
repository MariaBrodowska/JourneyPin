import SwiftUI
import MapKit

struct LocationToViewMap: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapViewToDisplay: View {
    @State private var region: MKCoordinateRegion
    private var annotations: [LocationToViewMap]

    init(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        _region = State(initialValue: region)
        annotations = [
            LocationToViewMap(name: "Wybrana lokalizacja", coordinate: coordinate)
        ]
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { location in
            MapMarker(coordinate: location.coordinate, tint: .red)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}
