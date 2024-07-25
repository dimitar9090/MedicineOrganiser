import Foundation

struct DrugResponse: Decodable {
    let results: [Drug]
}

struct Drug: Identifiable, Decodable {
    var id: String { openfda.rxcui?.first ?? UUID().uuidString }
    let openfda: OpenFDA
    let brand_name: [String]?
    let generic_name: [String]?
}

struct OpenFDA: Decodable {
    let rxcui: [String]?
    let brand_name: [String]?
    let generic_name: [String]?
}
