//
//  JourneyListView.swift
//  journeypin
//
//  Created by maria on 14/06/2025.
//

import SwiftUI
import CoreData

struct JourneyListView: View {
    @State var showAdd: Bool = false;
    @EnvironmentObject var currentUser: User;
    @Environment(\.managedObjectContext) private var viewContext

    @State var travels: [String] = [
            "Wycieczka do Włoch",
            "Wypad w góry"
    ]
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Trip.tripname, ascending: true)],animation: .default)
    private var trips : FetchedResults<Trip>
    var body: some View {
        NavigationStack {
            if filteredTrips.isEmpty {
                VStack {
                    Spacer()
                    Image(systemName: "figure.walk.motion")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    Text("Brak zapisanych podróży")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Naciśnij przycisk '+' aby dodać swoją pierwszą przygodę.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(filteredTrips, id: \.self) { travel in
                        NavigationLink(destination: ShowTripView(trip: travel)) {
                            TripRowView(trip: travel, formatter: itemFormatter)
                        }
                    }.onDelete(perform: deleteTrip)
                }
            }
           
        } .navigationTitle("Podróże")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddJourneyView().environmentObject(currentUser)) {
                        Image(systemName: "plus")
                    }
                }
            }
    }
    private var filteredTrips: [Trip] {
        trips.filter { $0.tripuser == currentUser }
    }
    private func deleteTrip(at offsets: IndexSet) {
       
                withAnimation {
                    for index in offsets {
                        let tripToDelete = filteredTrips[index]
                        
                        if tripToDelete.pinArray.count > 0 {
                            for pin in tripToDelete.pinArray {
                                viewContext.delete(pin)
                            }
                        }
                        
                        viewContext.delete(tripToDelete)
                    }
                    
                    do {
                        try viewContext.save()
                    } catch {
                        print("Błąd usuwania podróży: \(error.localizedDescription)")
                    }
                }
            }
    
   
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}
