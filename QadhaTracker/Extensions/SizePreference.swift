import SwiftUI

struct SizePreferenceKey: PreferenceKey {
	static var defaultValue: CGSize = .zero

	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
	}
}
