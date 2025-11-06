

import SwiftData
import Foundation
//Vorcheck: Bevor ich an Google Safe Browsing sende, host da- nicht da.
struct HostProbeService {
    private let session: URLSession

    init(timeoutSec: TimeInterval = 3) {
        let configuration = URLSessionConfiguration.ephemeral // kurze Prüfung ohne es in cache zuspeichern
        configuration.timeoutIntervalForRequest  = timeoutSec
        configuration.timeoutIntervalForResource = timeoutSec
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData // live Antwort(ohne cache)
        self.session = URLSession(configuration: configuration)
    }

    /// Anfrage an DNS über IP (true- false)
    func looksReal(_ url: URL) async -> Bool {
        guard let host = url.host,
              let probeURL = URL(string: "\(url.scheme ?? "https")://\(host)/") else { return false }

        var req = URLRequest(url: probeURL)
        req.httpMethod = "HEAD" // schneller, guckt ob host da ist

        do {
            let (_, resp) = try await session.data(for: req)
            return resp is HTTPURLResponse
        } catch let e as URLError {
            switch e.code {
            case .cannotFindHost, .dnsLookupFailed, .cannotConnectToHost, .timedOut:
                return false
            default:
                // fals host ist da, aber mit jeder art anderen Fehlern. " host exist"
                return true
            }
        } catch {
            return false
        }
    }
}
