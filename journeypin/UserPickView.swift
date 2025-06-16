import SwiftUI
import CoreData

struct UserPickView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss;
    @State var showAdd: Bool = false;
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)],
        animation: .default)
    private var items: FetchedResults<User>

    var body: some View {
            List {
                ForEach(items) { item in
                    Text("\(item.username!)")
                        .onTapGesture {
                            switchUser(pickedUser: item)
                        }
                }
                .onDelete(perform: deleteItems)
                
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showAdd.toggle();
                    }, label:{
                            Label("Dodaj profil", systemImage: "plus")
                    })
                    .sheet(isPresented: $showAdd) {
                        AddUserView()
                    }
                    	
                }
            }
        }
    private func switchUser(pickedUser: User) {
        for item in items {
            item.lastActive = false;
        }
        pickedUser.lastActive = true;
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
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
