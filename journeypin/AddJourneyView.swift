import SwiftUI

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
            
            Section(header:
                HStack {
                    Text("Lokalizacja")
                        .font(.title2)
                    Spacer()
                    Button(action: {
                        showMapView.toggle()
                    }) {
                        Text("Dodaj nową pinezkę")
                    }
                    .padding(15)
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            ) {
                VStack(alignment: .leading) {
                    Divider()
                    List {
                        ForEach(pins) { pin in
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
                            .padding(.vertical, 2)
                        }
                        .onDelete(perform: deletePin)
                        .onMove(perform: movePin)
                    }
                    .listStyle(.insetGrouped)
                    .padding(1)
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
    private func movePin(from source: IndexSet, to destination: Int) {
        pins.move(fromOffsets: source, toOffset: destination)
    }
    private func deletePin(at offsets: IndexSet) {
        pins.remove(atOffsets: offsets)
    }
}
