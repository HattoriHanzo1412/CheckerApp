import Foundation
import SwiftData

///главном потоке
@MainActor
final class URLCheckViewModel: ObservableObject {
    private let service   = GoogleSafeBrowsingService()
  
    private let hostProbe = HostProbeService()
    private let normalizer = URLNormalizer()

    ///Состояние ввода/вывода
    @Published var urlString: String = ""
    @Published var isLoading = false
    @Published var error: String?
    @Published var message: String?
    /// Последний вердикт: true ,false,nil
    @Published var lastIsSafe: Bool?

    ///Для истории (SwiftData)
    @Published var verdict: Bool?
    @Published var confidence: Double = 1.0    /// Google можно доверять.
    @Published var checkedURL: String = ""

    ///Главный сценарий: вызывается кнопкой чек.
    func check(saveTo context: ModelContext) async {
        /// Сброс состояния перед новой проверкой
        isLoading = true
        error = nil
        message = nil
        verdict = nil
        
        guard let url = normalizer.normalizedURL(urlString) else {
            isLoading = false
            lastIsSafe = nil
            error = "Incorrect address. Please enter a full URL (e.g. https://apple.com)."
            return
        }

        // --- 2) Быстро проверяем, что хост вообще существует/отвечает
        let hostIsReal = await hostProbe.looksReal(url)
        guard hostIsReal else {
            isLoading = false
            lastIsSafe = nil
            error = "It looks like this site does not exist."
            return
        }

        /// Основная проверка через Google Safe Browsing
        do {
            ///НЕ создаём сервис заново — используем свойство `service`
            let (isPhishing, bericht) = try await service.check(url: url.absoluteString)

            ///Обновляем состояние под UI
            isLoading   = false
            checkedURL  = url.absoluteString /// можно выбрать и другие части ссылки.
            verdict     = isPhishing
            lastIsSafe  = !isPhishing
            confidence  = 1.0
            message     = bericht ?? (isPhishing ? "⚠️ Threat detected" : "🟢 Safe")

            ///Сохраняем результат в историю (SwiftData)
            let item = URLCheck(
                url: url.absoluteString,
                isPhish: isPhishing,
                confidence: confidence,
                scannedAt: Date(),
                isFavorite: false
            )
            context.insert(item)
            try? context.save()

        } catch {
            ///Ошибка сети/конфигурации/декодинга и т.п.
            isLoading = false
            lastIsSafe = nil
            self.error = error.localizedDescription
        }
    }
}
