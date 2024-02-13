import SwiftUI

struct CreateMedicineEntryView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var date: Date = Date()
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Quantity", text: $quantity)
                DatePicker("Expire Date", selection: $date, displayedComponents: .date)
                
                Button("Take Picture") {
                    isImagePickerPresented.toggle()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(image: $selectedImage)
                }
                
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
            }
            .background(CustomBackgroundView())
            .scrollContentBackground(.hidden)
            .navigationTitle("New Medicine Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newMedicineEntry = MedicineEntry(name: name, quantity: quantity, date: date)
                        // You might want to associate the selected image with the medicine entry.
                         //newMedicineEntry.image = selectedImage
                        modelContext.insert(newMedicineEntry)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CreateMedicineEntryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMedicineEntryView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
}
