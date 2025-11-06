import Foundation
/// Commit
struct GoogleSafeBrowsingService {
    /// Асинхронная проверка URL через Google Safe Browsing.
    /// Возвращает. (обнаружена угроза, текст для пользователя?)
    func check(url: String) async throws -> (Bool, String?) {
        let urlToCheck = url.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_SAFE_BROWSING_API_KEY") as? String,
              !apiKey.isEmpty else {
            throw GSBError.misconfigured("Missing GOOGLE_SAFE_BROWSING_API_KEY in Info.plist")
        }

        guard let endpoint = URL(string: "https://safebrowsing.googleapis.com/v4/threatMatches:find?key=\(apiKey)") else {
            throw GSBError.badInput("Invalid endpoint URL")
        }

        let body = GSBRequestBody(
            client: .init(clientId: "phishchecker", clientVersion: "1.0"),
            threatInfo: .init(
                threatTypes: ["MALWARE","SOCIAL_ENGINEERING","UNWANTED_SOFTWARE","POTENTIALLY_HARMFUL_APPLICATION"],
                platformTypes: ["ANY_PLATFORM"],
                threatEntryTypes: ["URL"],
                threatEntries: [["url": urlToCheck]]
            )
        )
///Этот блок готовит запрос к отправке
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.timeoutInterval = 12
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
///Abfrage
        let (data, response) = try await URLSession.shared.data(for: request)
        try sicherStellen(response, data: data) /// mein Helper
/// Anrwort decode
        let result = try JSONDecoder().decode(GoogleSafeBrowsingResult.self, from: data)
        /// guckt  ob es Problem gibt
        if let matches = result.matches, !matches.isEmpty {
            let types = Array(Set(matches.map { $0.threatType })).sorted()
            let message = "⚠️ threat detected (\(types.joined(separator: ", ")))"
            return (true, message)
        } else {
            return (false, nil)
        }
    }

    /// Частный хелпер
    private func sicherStellen(_ response: URLResponse, data: Data) throws {
        guard let http = response as? HTTPURLResponse else { return }
        guard (200...299).contains(http.statusCode) else {
            let text = String(data: data, encoding: .utf8) ?? ""
            throw GSBError.http(http.statusCode, text)
        }
    }
}
