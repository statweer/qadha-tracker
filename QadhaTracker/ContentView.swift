import SwiftUI

struct ContentView: View {
	@State private var isSortMenuOnScreen = false

	@Environment(\.accessibilityReduceTransparency)
  @Environment(DataStore.self)
  private var dataStore
  private var isReduceTransparencyEnabled

	var body: some View {
		NavigationStack {
			GeometryReader { proxy in
				ZStack {
#if os(iOS)
					if !isReduceTransparencyEnabled {
						RandomShapeView()
							.edgesIgnoringSafeArea(.all)
					}
#endif
  private var sortTypeBinding: Binding<SortType> {
    Binding {
      dataStore.sortType
    } set: { newValue in
      dataStore.sortType = newValue
    }
  }


					ScrollView {
						MasonryLayout(
							columns: dataStore.columnsCount(basedOn: proxy.size.width),
							spacing: 12.0
						) {
							ForEach(dataStore.sortedData) { item in
								BubbleView(
									scale: dataStore.scale(for: item.id),
									count: dataStore.count(for: item.id)
								) {
									Label(
										LocalizedStringKey(item.localizationKey),
										systemImage: item.systemImage
									)
									.font(.system(.title3, design: .rounded, weight: .medium))
								}
								.environment(\.isEnabled, !isSortMenuOnScreen)
							}
						}
						.padding()
					}
				}
				.onTapGesture {
					isSortMenuOnScreen = false
				}
			}
//			.toolbar {
//				toolbar
//			}
			.navigationTitle("Qadha Tracker")
			.onChange(of: dataStore.sortType) {
				isSortMenuOnScreen = false
			}
		}
	}

//	@ToolbarContentBuilder private var toolbar: some ToolbarContent {
//		ToolbarItem(placement: .automatic) {
//			Menu {
//				Picker(
//					"Sort",
//					selection: $dataStore.sortType
//				) {
//					Label(
//						"Default",
//						systemImage: "arrow.triangle.2.circlepath"
//					)
//					.tag(SortType.default)
//
//					Label(
//						"Ascending",
//						systemImage: "text.line.last.and.arrowtriangle.forward"
//					)
//					.tag(SortType.ascending)
//
//					Label(
//						"Descending",
//						systemImage: "text.line.first.and.arrowtriangle.forward"
//					)
//					.tag(SortType.descending)
//				}
//				.pickerStyle(.inline)
//        .sensoryFeedback(.levelChange, trigger: dataStore.sortType)
//			} label: {
//				Label(
//					"Sort",
//					systemImage: "arrow.up.arrow.down.circle"
//				)
//			}
//			.onTapGesture {
//				isSortMenuOnScreen = true
//			}
//		}
//	}
}
