import SwiftUI

struct AddUserView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var nazwa: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
                    Text("Dodaj profil")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black.opacity(0.85))

                    
                    VStack(spacing: 10) {
                        Text("Nazwa profilu")
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.85))

                        TextField("", text: $nazwa, prompt: Text("Wprowadź nazwę...")
                            .foregroundColor(.black))
                            .padding()
                            .frame(maxWidth: 300)
                            .background(.gray.opacity(0.5))
                            .cornerRadius(15)
                            }
                    .padding(.horizontal, 40)

                    Spacer()

                    Button(action: addUser) {
                        Text("Dodaj profil")
                            .fontWeight(.semibold)
                            .frame(maxWidth: 200)
                            .padding()
                            .background(Color.teal)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    Spacer()
                }
                .padding()
    }
    
    private func addUser() {
        if nazwa.isEmpty {
            return
        }
        let newUser = User(context: viewContext)
        newUser.username = nazwa
        do {
            try viewContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
