---
name: Swift Concurrency
description: Patterns for async/await, actors, and structured concurrency in Swift
category: ios
triggers: ["/async", "/concurrency"]
version: "1.0"
author: Georg
tags: [swift, concurrency, async-await]
---

# Swift Concurrency Patterns

## Async/Await

```swift
func fetchData() async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
```

## Actors

Use actors for thread-safe mutable state:

```swift
actor DataStore {
    private var cache: [String: Data] = [:]

    func store(_ data: Data, for key: String) {
        cache[key] = data
    }
}
```

## Task Groups

For parallel work:

```swift
await withTaskGroup(of: Result.self) { group in
    for item in items {
        group.addTask { await process(item) }
    }
}
```
