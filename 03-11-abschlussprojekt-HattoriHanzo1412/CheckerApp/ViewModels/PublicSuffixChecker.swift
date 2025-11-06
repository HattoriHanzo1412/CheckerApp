
import Foundation
import SwiftData

struct PublicSuffixChecker {
    /// TLD in lowercased
    var singleLabel: [String] = [
        "com","net","org","io","app","dev","de","ru","it","uk","ai","info","biz","me","us","ca",
        "ch","at","nl","be","pl","se","no","dk","fi","cz","sk","hu","fr","es","pt","ro","bg","tr","gr",
        "jp","kr","in","id","au","mx","br","ar","ua","lt","lv","ee","il","sa","ae","by","rs","md",
        "th","ph","my","sg","hk","tw","vn","za","ng","eg","ma","kz","uz","am","az","ge"
    ]
///multi TLD
    var multiLabel: [String] = [
        "co.uk","com.au","com.br","com.tr","co.jp","com.mx","com.ar","co.kr","co.in"
    ]

    func isValidSuffix(host: String) -> Bool {
        let normal = host.lowercased()

        //  (co.uk.... u.s.w)
        if multiLabel.contains(where: { normal == $0 || normal.hasSuffix("." + $0) }) {
            return true
        }

        // normal TLDs
        guard let tld = normal.components(separatedBy: ".").last else { return false }
        return singleLabel.contains(String(tld))
    }
}
