//
//  ContentView.swift
//  NavigationSplitViewPlayground
//
//  Created by Ryan Zulkoski on 3/22/23.
//

import Introspect
import SwiftUI

struct AppRootView: View {
    var body: some View {
		// 1
		NavigationSplitView(columnVisibility: .constant(.doubleColumn)) {
			ListView()
				.introspectSplitViewController { split in
					split.displayModeButtonVisibility = .never
				}
		} detail: {
			Text("Empty View")
		}
		.navigationSplitViewStyle(.balanced)
//
//		// 2
//		NavigationStack {
//			ListView()
//		}
//
//		// 3
//		NavigationView {
//			ListView()
//				.introspectSplitViewController { split in
//					split.displayModeButtonVisibility = .never
//				}
//		}
//		.navigationViewStyle(.columns)
	}
}

struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView()
    }
}

struct ListView: View {
	@State private var selectedId: Int?

	var body: some View {
		List {
			ForEach(0..<10, id: \.self) { rowId in
				NavigationLink {
					DetailsWrapperView(id: rowId)
						.ignoresSafeArea()
						.navigationTitle("Row \(rowId) details")
						.navigationBarTitleDisplayMode(.inline)
				} label: {
					Text("Row \(rowId)")
				}
			}
		}
		.listStyle(.insetGrouped)
		.navigationTitle("List")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct DetailsWrapperView: UIViewControllerRepresentable {
	let id: Int

	func makeUIViewController(context: Context) -> DetailsViewController {
		DetailsViewController(id: self.id)
	}

	func updateUIViewController(_ uiViewController: DetailsViewController, context: Context) {
		//
	}
}

class DetailsViewController: UIViewController {
	private(set) var id: Int!

	init(id: Int) {
		self.id = id
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .red

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.view.backgroundColor = .white
		}
	}
}
