


import Foundation

struct URLNormalizer {
    /// validiert die  Endung (TLD / Public Suffix) über  PublicSuffixChecker
    private let suffixChecker = PublicSuffixChecker()

    /// Wandelt Roh-Text in eine gültige URL um oder liefert  nil
    func normalizedURL(_ rawInput: String) -> URL? {
        /// Whitespacer löser
        var cleanedInput = rawInput.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        guard !cleanedInput.isEmpty else { return nil }

        /// Scheme ergänzen, wenn der Nutzer keines angegeben hat
        let lowercased = cleanedInput.lowercased()
        if !lowercased.hasPrefix("http://") && !lowercased.hasPrefix("https://")
        {
            cleanedInput = "https://" + cleanedInput
        }

        /// In URL parsen und sicherstellen, dass ein Host vorhanden ist
        guard let url = URL(string: cleanedInput),
            let host = url.host
        else {
            return nil
        }

        /// Host-Endung (TLD / Public Suffix) gegen Whitelist prüfen
        guard suffixChecker.isValidSuffix(host: host) else { return nil }

        return url
    }
}
