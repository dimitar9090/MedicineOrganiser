import SwiftUI
import SwiftData

struct MedicineEntriesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \MedicineEntry.name) private var medicineEntries: [MedicineEntry]

    @State var showCreateView = false
    @State private var searchText = ""
    @State private var showAlert = false
    @State private var expiredMedicine: MedicineEntry?

    var body: some View {
        NavigationStack {
            ZStack {
                CustomBackgroundView()

                List {
                    ForEach(searchResults) { listedMedicineEntry in
                        NavigationLink(destination: EditMedicineEntryView(editingMedicineEntry: listedMedicineEntry)) {
                            MedicineEntryRowView(rowMedicineEntry: listedMedicineEntry, isExpired: isMedicineExpired(listedMedicineEntry))
                                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let medicineEntry = medicineEntries[index]
                            modelContext.delete(medicineEntry)
                        }
                        do {
                            try modelContext.save()
                        } catch {
                            print("Error saving context: \(error)")
                        }
                    }
                }
                .animation(.easeInOut, value: searchResults)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Text("\(medicineEntries.count) Лекарства").font(.system(size: 40).bold()))
                .toolbar {
                    Button(action: {
                        showCreateView = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                .sheet(isPresented: $showCreateView) {
                    CreateMedicineEntryView()
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Medicine Expired"),
                        message: Text("\(expiredMedicine?.name ?? "") has expired."),
                        dismissButton: .default(Text("OK")) {
                            
                        }
                    )
                }
            }
            .scrollContentBackground(.hidden)
            .searchable(text: $searchText)
            .onAppear {
                checkMedicineExpiry()
            }
        }
    }

    var searchResults: [MedicineEntry] {
        if searchText.isEmpty {
            return medicineEntries
        } else {
            return medicineEntries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    func isMedicineExpired(_ medicineEntry: MedicineEntry) -> Bool {
        let currentDate = Date()
        return medicineEntry.date < currentDate
    }

    func checkMedicineExpiry() {
        let currentDate = Date()

        for medicineEntry in medicineEntries.sorted(by: { $0.date < $1.date }) {
            if Calendar.current.isDate(medicineEntry.date, inSameDayAs: currentDate) {
                expiredMedicine = medicineEntry
                showAlert = true
                break // Exit the loop after finding the first expired medicine
            }
        }
    }
}

struct MedicineEntriesListView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineEntriesListView()
            .modelContainer(for: MedicineEntry.self, inMemory: false) // Use non-in-memory store
    }
}
