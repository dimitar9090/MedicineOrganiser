import Foundation

struct DrugResponse: Decodable {
    let results: [Drug]
}

struct Drug: Identifiable, Decodable {
    let id = UUID()
    let openfda: OpenFDA
    let brand_name: [String]?
    let generic_name: [String]?
    let indications_and_usage: [String]?
    let dosage_and_administration: [String]?
    let warnings: [String]?
    let drug_interactions: [String]?
    let adverse_reactions: [String]?

    enum CodingKeys: String, CodingKey {
        case openfda
        case brand_name
        case generic_name
        case indications_and_usage
        case dosage_and_administration
        case warnings
        case drug_interactions
        case adverse_reactions
    }
}

struct OpenFDA: Decodable {
    let rxcui: [String]?
    let brand_name: [String]?
    let generic_name: [String]?

    enum CodingKeys: String, CodingKey {
        case rxcui
        case brand_name
        case generic_name
    }
}
