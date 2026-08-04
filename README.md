# CryptoTracker 📈

A native iOS cryptocurrency tracking app built with SwiftUI, following production-grade Clean Architecture patterns. CryptoTracker lets users browse live market data, manage a personal portfolio, and track holdings in real time.

## App Features

- **Live cryptocurrency data** — real-time prices and market stats pulled from a public crypto market API
- **Portfolio management** — save, update, and remove coin holdings, persisted locally per user
- **Search, filter, sort & reload** — instantly search coins, sort by rank/price/holdings, and pull-to-refresh for the latest data
- **Custom theming & loading animations** — a consistent color theme (light/dark support) and polished loading states throughout the app

## Technical Features

- **MVVM Architecture** — clear separation between Views, ViewModels, and data layers for testability and maintainability
- **Core Data** — persists the user's portfolio locally on-device
- **FileManager** — caches coin images on disk to reduce redundant network calls
- **Combine** — reactive publishers/subscribers power live data streams, search debouncing, and state updates across the app
- **Multiple API integrations** — coin list, market statistics, and coin detail endpoints, each cleanly abstracted behind a repository layer
- **Codable** — JSON decoding for all API and persistence models
- **100% SwiftUI** — the entire interface is built natively in SwiftUI, no UIKit view code
- **Multi-threading** — networking and data processing run on background threads, with UI updates dispatched to the main thread
- **Safe coding practices** — consistent use of `if let` / `guard let` throughout to prevent force-unwrap crashes and handle missing data gracefully

## Architecture Overview

```
View (SwiftUI)
   ↓ ↑
ViewModel (Combine, @Published state)
   ↓ ↑
Repository / Data Service (throws / Combine publishers)
   ↓ ↑
API Client (URLSession) · Core Data · FileManager
```

- **Presentation layer**: SwiftUI Views bind to `ObservableObject` ViewModels via `@Published` properties
- **Domain/Data layer**: Repositories expose protocol-based interfaces so implementations can be swapped or mocked for testing
- **Persistence layer**: Core Data manages the portfolio; FileManager handles image caching
- **Dependency Injection**: ViewModels and repositories are injected via a lightweight `DIContainer`, keeping components decoupled and testable

## Tech Stack

| Layer | Tools |
|---|---|
| UI | SwiftUI |
| Reactive/State | Combine |
| Networking | URLSession, Codable |
| Persistence | Core Data, FileManager |
| Architecture | MVVM, protocol-based Repository pattern |

## Requirements

- iOS 17+
- Xcode 15+
- Swift 5.9+

## Getting Started

1. Clone the repository
2. Open `CryptoTracker.xcodeproj` in Xcode
3. Build and run on simulator or device

## Roadmap / Possible Next Steps

- Modularize into Swift Packages (Core, Networking, DesignSystem, Features)
- Add unit tests for ViewModels and Repositories
- Introduce Swinject or a similar DI framework as the app scales
- WebSocket-based live price streaming

## Author

Mahmoud Hassan
[GitHub](https://github.com/MahmoudHassan9)
