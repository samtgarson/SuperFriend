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

**Type-Safe Navigation** (SuperFriend/App/Navigation/):
- Uses `AppNavigation` with @Observable pattern from pointfreeco/swift-navigation
- `path: [Path]` - Array for push navigation in NavigationStack (contactPicker, settings, playground)
- `activeSheet: ActiveSheet?` - Optional for which sheet flow is presented
- `friendFlowPath: [FriendFlowPath]` - Array for navigation within friend sheet
- All routes defined in @CasePathable enums for compile-time type safety
- Navigation is state-driven: mutate properties to trigger navigation
- Automatic cleanup: `didSet` on `activeSheet` resets flow paths
- Centralized at app level, passed to screens as `navigation`

**Navigation Patterns:**
- Push: `navigation.path.append(.routeName)`
- Pop: `navigation.path.removeLast()` or use system back button
- Present sheet: `navigation.activeSheet = .friendFlow(friend:contactData:)`
- Dismiss sheet: `navigation.activeSheet = nil` (auto-resets friendFlowPath)
- Navigate within sheet: `navigation.friendFlowPath.append(.edit)`
- Pop within sheet: `navigation.friendFlowPath.removeLast()`

**Sheet Architecture:**
- Each sheet can have its own NavigationStack for sub-navigation
- Friend flow: New friends start at EditContactScreen (root), existing friends start at FriendDetailsScreen (can navigate to edit)
- Future flows can add their own path arrays (e.g., `settingsFlowPath`)

### UI Architecture

**Feature Structure** (SuperFriend/App/Features/):
- Each feature has its own directory (e.g., `FriendList/`, `EditContact/`, `FriendDetails/`, `Settings/`)
- Typical structure: `*Screen.swift` (view), `*ViewModel.swift` (business logic)
- ViewModels use `@Published` properties and repository pattern for data access
- Screens receive `navigation: AppNavigation` for navigation capability

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
- Models used in navigation must conform to `Hashable`

### Navigation Pattern
- Navigation model passed to screens as `navigation: AppNavigation` parameter
- State-driven navigation: mutate `path`, `activeSheet`, or `friendFlowPath` properties
- Routes with associated values pass data through enum cases (e.g., `.friendFlow(friend:contactData:)`)
- ViewModels take completion closures (e.g., `onComplete: { navigation.activeSheet = nil }`)

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
