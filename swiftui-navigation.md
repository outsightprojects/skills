---
name: SwiftUI Navigation
description: NavigationStack and NavigationSplitView patterns for iOS and macOS
category: ios
triggers: ["/nav", "/navigation"]
version: "1.0"
author: Georg
tags: [swiftui, navigation, ios, macos]
---

# SwiftUI Navigation

## NavigationSplitView (macOS)

```swift
NavigationSplitView {
    SidebarView()
} detail: {
    DetailView()
}
```

## NavigationStack (iOS)

```swift
NavigationStack(path: $path) {
    List(items) { item in
        NavigationLink(value: item) {
            ItemRow(item: item)
        }
    }
    .navigationDestination(for: Item.self) { item in
        ItemDetail(item: item)
    }
}
```

## Tips

- Use `@SceneStorage` for selection persistence
- Store IDs, not objects, in navigation state
- Use `navigationTitle` for window titles
