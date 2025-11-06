import Foundation

enum GSBError: Error, LocalizedError {
    case badInput(String)
    case http(Int, String) ///ассоциированных values
    case misconfigured(String)

    var errorDescription: String? {
        switch self {
        case .badInput(let text):
                return text
        case .http(let code, let body):
                return "GSB HTTP \(code): \(body)"
        case .misconfigured(let message):
                return message
        }
    }
}
