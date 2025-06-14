//
//  ContentView.swift
//  journeypin
//
//  Created by maria on 27/05/2025.
//

import SwiftUI
import CoreData

struct UserPickView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss;
    @State var showAdd: Bool = false;
    @Binding var currentUser: User?;
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)],
        animation: .default)
    private var items: FetchedResults<User>

    var body: some View {
            List {
                ForEach(items) { item in
                    Button(action: {
                        switchUser(pickedUser: item)
                    }, label: {
                        Text(item.username!)
                    })
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showAdd.toggle();
                    }, label:{
                            Label("Add user", systemImage: "plus")
                    })
                    .sheet(isPresented: $showAdd) {
                        AddUserView()
                    }
                    	
                }
            }
        }
    private func switchUser(pickedUser: User) {
        currentUser = pickedUser;
        dismiss();
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
        


#Preview {
    UserPickView(currentUser: .constant(nil)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
}
