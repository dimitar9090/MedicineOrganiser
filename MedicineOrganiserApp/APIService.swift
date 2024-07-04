//
//  APIService.swift
//  MedicineOrganiserApp
//
//  Created by Dimitar Angelov on 10.06.24.
//

import Foundation
import Combine

class APIService: ObservableObject {
    @Published var drugLabels = [DrugLabel]()
    private var cancellable: AnyCancellable?

    func fetchDrugLabels() {
        guard let url = URL(string: "https://api.fda.gov/drug/label.json") else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: DrugLabelResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.drugLabels = response.results
            })
    }
}
