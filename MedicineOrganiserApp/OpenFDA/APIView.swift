import SwiftUI

struct APIView: View {
    @State private var drugs: [Drug] = []
    @State private var query: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    @State private var selectedDrug: Drug?

    private let service = OpenFDAService()

    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView() // Optional: Your custom background view

                VStack {
                    TextField("Enter drug name", text: $query, onCommit: fetchData)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.pink)
                    
                    if isLoading {
                        ProgressView()
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.black)
                    } else {
                        List {
                            ForEach(drugs) { drug in
                                VStack(alignment: .leading) {
                                    Text("Brand Name: \(drug.brand_name?.first ?? drug.openfda.brand_name?.first ?? "N/A")")
                                    Text("Generic Name: \(drug.generic_name?.first ?? drug.openfda.generic_name?.first ?? "N/A")")
                                }
                                .onTapGesture {
                                    selectedDrug = drug
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                }
                .padding()
            }
            .navigationTitle("Drug Information")
            .sheet(item: $selectedDrug) { drug in
                DrugDetailView(drug: drug)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func fetchData() {
        isLoading = true
        errorMessage = nil
        service.fetchDrugInformation(query: query) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let response):
                    if response.results.isEmpty {
                        errorMessage = "No results found for \"\(query)\". Try another search term."
                    } else {
                        drugs = response.results
                    }
                case .failure(let error):
                    errorMessage = "Failed to load data: \(error.localizedDescription)"
                    print("Error details: \(error)")
                }
            }
        }
    }
}

struct DrugDetailView: View {
    let drug: Drug

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                DetailSection(title: "Brand Name", content: drug.brand_name?.first ?? drug.openfda.brand_name?.first ?? "N/A")
                DetailSection(title: "Generic Name", content: drug.generic_name?.first ?? drug.openfda.generic_name?.first ?? "N/A")
                DetailSection(title: "Indications and Usage", content: drug.indications_and_usage?.first ?? "N/A")
                DetailSection(title: "Dosage and Administration", content: drug.dosage_and_administration?.first ?? "N/A")
                DetailSection(title: "Warnings", content: drug.warnings?.first ?? "N/A")
                DetailSection(title: "Drug Interactions", content: drug.drug_interactions?.first ?? "N/A")
                DetailSection(title: "Adverse Reactions", content: drug.adverse_reactions?.first ?? "N/A")
            }
            .padding()
        }
        .navigationTitle(drug.brand_name?.first ?? drug.generic_name?.first ?? "Drug Details")
    }
}

struct DetailSection: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
            Text(content)
                .font(.body)
        }
        .padding(.vertical, 5)
    }
}

struct APIView_Previews: PreviewProvider {
    static var previews: some View {
        APIView()
    }
}
