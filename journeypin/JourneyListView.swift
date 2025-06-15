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
    
    @FetchRequest(
            entity: Trip.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Trip.date, ascending: false)],
            predicate: nil,
            animation: .default
        ) private var allTrips: FetchedResults<Trip>
    
    var body: some View {
        NavigationStack {
                    List {
                        ForEach(filteredTrips) { trip in
                            VStack(alignment: .leading) {
                                Text(trip.tripname ?? "Bez nazwy")
                                    .font(.headline)
                                if let date = trip.date {
                                    Text(date.formatted(date: .abbreviated, time: .omitted))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
            .navigationTitle("Podróże")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: AddJourneyView().environmentObject(currentUser)) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
    }
    private var filteredTrips: [Trip] {
        allTrips.filter { $0.tripuser == currentUser }
    }
}
