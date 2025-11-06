

// Request model (Anfrage an Google)
struct GSBRequestBody: Encodable {
    struct Client: Encodable {
        let clientId: String
        let clientVersion: String
    }
    struct ThreatInfo: Encodable {
        let threatTypes: [String]
        let platformTypes: [String]
        let threatEntryTypes: [String]
        let threatEntries: [[String: String]]
    }

    let client: Client
    let threatInfo: ThreatInfo
}
