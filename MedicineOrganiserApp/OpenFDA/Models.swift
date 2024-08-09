//
//  Models.swift
//  MedicineOrganiserApp
//
//  Created by Dimitar Angelov on 10.08.24.
//

import Foundation

struct DrugResponse: Decodable {
    let results: [Drug]
}

struct Drug: Identifiable, Decodable {
    var id: String { openfda.rxcui?.first ?? UUID().uuidString }
    let openfda: OpenFDA
    let brand_name: [String]?
    let generic_name: [String]?

    // Custom decoding to handle missing data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.openfda = try container.decodeIfPresent(OpenFDA.self, forKey: .openfda) ?? OpenFDA(rxcui: nil, brand_name: nil, generic_name: nil)
        self.brand_name = try container.decodeIfPresent([String].self, forKey: .brand_name)
        self.generic_name = try container.decodeIfPresent([String].self, forKey: .generic_name)
    }

    enum CodingKeys: String, CodingKey {
        case openfda
        case brand_name
        case generic_name
    }
}

struct OpenFDA: Decodable {
    let rxcui: [String]?
    let brand_name: [String]?
    let generic_name: [String]?

    // Custom decoding to handle missing data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.rxcui = try container.decodeIfPresent([String].self, forKey: .rxcui)
        self.brand_name = try container.decodeIfPresent([String].self, forKey: .brand_name)
        self.generic_name = try container.decodeIfPresent([String].self, forKey: .generic_name)
    }

    enum CodingKeys: String, CodingKey {
        case rxcui
        case brand_name
        case generic_name
    }
}
