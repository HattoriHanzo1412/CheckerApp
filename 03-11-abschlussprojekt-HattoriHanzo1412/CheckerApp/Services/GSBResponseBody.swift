


import Foundation

//  Response model ( Antwort von Google)
struct GoogleSafeBrowsingResult: Decodable {
    let matches: [Match]?

    struct Match: Decodable {
        let threatType: String
        let platformType: String
        let threatEntryType: String
        let threat: Threat?

        struct Threat: Decodable {
            let url: String?
        }
    }
}

