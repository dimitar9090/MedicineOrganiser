import SwiftUI

struct APIView: View {
    @State private var drugs: [Drug] = []
    @State private var query: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    private let service = OpenFDAService()

    var body: some View {
        NavigationView {
            ZStack {
                CustomBackgroundView()

                VStack {
                    TextField("Enter drug name", text: $query, onCommit: fetchData)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.pink)
                    
                    if isLoading {
                        ProgressView()
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                    } else {
                        List {
                            ForEach(drugs) { drug in
                                VStack(alignment: .leading) {
                                    Text("Brand Name: \(drug.brand_name?.first ?? "N/A")")
                                    Text("Generic Name: \(drug.generic_name?.first ?? "N/A")")
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                }
                .padding()
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "pills.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                        Text("Drugs Information")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func fetchData() {
        isLoading = true
        service.fetchDrugInformation(query: query) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let response):
                    drugs = response.results
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct APIView_Previews: PreviewProvider {
    static var previews: some View {
        APIView()
    }
}
