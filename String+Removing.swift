import Foundation

extension String {
    func removingOccurrences(ary: [String]) -> String {
        var str = self
        ary.forEach { str = str.replacingOccurrences(of: $0, with: "") }
        return str
    }
}
