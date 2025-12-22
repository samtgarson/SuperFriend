# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SuperFriend is a native iOS/macOS SwiftUI application for managing friend connections. It helps users track when they last connected with friends and reminds them to reach out based on customizable periods (weekly, monthly, etc.).

## Technology Stack

- **SwiftUI** - UI framework
- **SwiftData** - Persistence layer (uses `@Model` macro for data models)
- **Contacts Framework** - iOS Contacts integration for friend data
- **Routing** (obvios/Routing) - Type-safe navigation using an enum-based router pattern
- **SwiftLint** - Code linting via Swift Package Plugin (SwiftLintPlugins 0.57.1)

## Development Commands

### Building and Running
```bash
# Open in Xcode
open SuperFriend.xcodeproj

# Build from command line
xcodebuild -scheme SuperFriend -configuration Debug build

# Run tests (when they exist)
xcodebuild test -scheme SuperFriend
```

### Linting
SwiftLint runs automatically via Swift Package Plugin during builds. No separate command needed.

### Database Access
The app prints the SQLite database path on launch. Use it with:
```bash
sqlite3 "<path-from-console>"
```

## Architecture

### Data Layer

**SwiftData Models** (SuperFriend/App/Models/):
- `Friend` - Main model storing contact identifier, period for reconnection, and relationship to ConnectionEvents
- `ConnectionEvent` - Records when a connection happened (message/meetup)
- Models use `@Model` macro and are managed by SwiftData's `ModelContainer`

**Database** (Database.swift):
- Singleton wrapper around SwiftData's `ModelContainer`
- Provides `testInstance()` for in-memory testing with optional seed data
- Schema defined in `Database.models` array

**Repository Pattern** (SuperFriend/App/Repositories/):
- `ModelRepository<Model>` - Generic CRUD operations for any `PersistentModel`
  - `upsert()`, `delete()`, `find()`, `query()` methods
  - All operations are `@MainActor` and work with `ModelContext`
- `ContactDataRepository` - Wraps iOS Contacts framework (`CNContactStore`)
  - Handles authorization and fetching contact data
  - Includes `TestContactDataRepository` subclass for testing

### Navigation

**Type-Safe Routing** (SuperFriend/App/Features/Router/):
- Uses `Router<AppRoutes>` from the Routing package
- `AppRoutes` enum defines all routes with associated values (e.g., `.editFriend(Friend)`)
- Each route specifies `navigationType` (.push or .sheet)
- Navigation is centralized and type-safe - use `router.routeTo()` and `router.dismiss()`

### UI Architecture

**Feature Structure** (SuperFriend/App/Features/):
- Each feature has its own directory (e.g., `FriendList/`, `EditContact/`)
- Typical structure: `*Screen.swift` (view), `*ViewModel.swift` (business logic)
- ViewModels use `@Published` properties and repository pattern for data access

**Design System** (SuperFriend/App/Styles/):
- `Tokens.swift` - Design tokens as CGFloat/Double extensions:
  - Spacing: `.xs`, `.sm`, `.md`
  - Corner radii: `.cornerRadiusSmall`, `.cornerRadius`
  - Durations: `.transition`, `.transitionFast`
  - Opacities: `.opacityFaded`, etc.
- Button modifiers: `PrimaryButton`, `AsyncButtonModifier`, `NakedButton`
- Use `.cornerRadius`, `.sm` spacing, etc. throughout the app

**Components** (SuperFriend/App/Components/):
- Reusable UI components like `Avatar`, `Box`, `TopNavBar`, `SwipeIcon`
- Keep components generic and composable

### Data Flow

1. **Contact Integration**: `Friend` stores only `contactIdentifier` (string)
2. **Lazy Loading**: `Friend.contact` property uses `@Transient` repository to fetch contact data on-demand
3. **Connection Tracking**: `ConnectionEvent` records are created when users mark a connection
4. **Due Date Calculation**: `Friend.daysUntilDue` compares last connection + period against current date

### Testing Patterns

- Use `Database.testInstance()` for in-memory SwiftData during tests/previews
- Use `TestContactDataRepository` with dummy data for contact-related tests
- SwiftUI previews use `.modelContainer(Database.testInstance(with: PreviewData.friends).container)`

## Key Patterns

### SwiftData Usage
- Models must be marked with `@Model` and use `@Relationship` for relationships
- Use `@Transient` for non-persisted properties (like repositories)
- All database operations via `ModelRepository` must be `@MainActor`
- Use `#Predicate` for type-safe queries

### Router Pattern
- Screens receive `router: AppRouter` and store as `@StateObject`
- Navigate with `router.routeTo(.routeName)` or `router.dismiss()`
- Routes with associated values pass data through enum cases
- ViewModels take completion closures (e.g., `onComplete: { router.dismiss() }`)

### Repository Injection
- ViewModels accept repository via init with default value: `repo: ModelRepository<Friend> = ModelRepository()`
- Allows test injection while keeping production code simple
- `@Transient` repositories in models use default initializers

## Project Structure

```
SuperFriend/
├── SuperFriendApp.swift          # App entry point
├── Info.plist
├── App/
│   ├── Models/                   # SwiftData models
│   │   ├── Database.swift
│   │   ├── Friend.swift
│   │   ├── ContactData.swift
│   │   └── ConnectionEvent.swift
│   ├── Repositories/             # Data access layer
│   ├── Features/                 # Feature modules
│   │   ├── Router/               # Navigation
│   │   ├── FriendList/
│   │   ├── EditContact/
│   │   └── ContactPicker/
│   ├── Components/               # Reusable UI components
│   ├── Styles/                   # Design tokens & modifiers
│   ├── Enums/                    # Shared enums
│   ├── Extensions/               # Swift extensions
│   └── Protocols/                # Shared protocols
└── Preview Content/
    └── PreviewData.swift         # Mock data for previews
```

## Important Notes

- **Main Actor**: All SwiftData operations must run on `@MainActor`
- **Contact Permissions**: Check `authorizationStatus()` before accessing contacts
- **Router Lifecycle**: Screens must hold router as `@StateObject`, not `@ObservedObject`
- **Transient Properties**: Use `@Transient` for computed or non-persisted model properties
- **SwiftLint**: Code must pass SwiftLint rules (runs automatically on build)
