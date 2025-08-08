# Range Visualizer App

A Flutter application that visualizes numeric ranges with an interactive interface. The app fetches range data from an API and displays it as a color-coded horizontal bar, allowing users to input values and see their position within the ranges.

## Project Structure

```
lib/
├── main.dart                    # Application entry point
├── app.dart                     # Root application widget
├── constant/
│   └── api_constants.dart       # API configuration constants
├── logic/
│   ├── notifiers.dart          # Global state management using ValueNotifier
│   └── range_loader.dart       # Business logic for loading ranges
├── model/
│   ├── range_model.dart        # Data model for range objects
│   ├── range_segment.dart      # Model for UI range segments
│   └── indicator_pos.dart      # Model for indicator positioning
├── service/
│   └── api.dart                # HTTP client for API communication
├── ui/
│   ├── page/
│   │   └── home_page.dart      # Main application page
│   └── widget/
│       ├── input_field.dart    # User input widget
│       ├── range_bar.dart      # Range visualization widget
│       ├── indicator_widget.dart # Position indicator widget
│       ├── loading_widget.dart  # Loading state widget
│       └── error_widget.dart    # Error state widget
└── util/
    ├── color.dart              # Color utility functions
    └── dimension.dart          # Dimension calculation utilities
```

## Architecture Overview

### Business Logic Decoupling

The application follows a clean architecture pattern that completely separates business logic from UI components:

#### 1. State Management Layer (`logic/`)
- **Notifiers**: Centralized state management using Flutter's `ValueNotifier`
- **RangeLoader**: Pure business logic class that handles data fetching and state updates
- No direct UI dependencies in business logic classes

#### 2. Data Layer (`model/` & `service/`)
- **Models**: Plain Dart classes representing data structures
- **API Service**: HTTP client abstraction for external data sources
- **Constants**: Configuration values separated from implementation

#### 3. Presentation Layer (`ui/`)
- **Widgets**: Purely reactive UI components that listen to state changes
- **Pages**: Screen-level composition of widgets
- No business logic embedded in UI components

#### 4. Utility Layer (`util/`)
- **Pure Functions**: Stateless utility classes for calculations and transformations
- **Color Utils**: Hex to Color conversion utilities
- **Dimension Utils**: Mathematical calculations for UI positioning

### setState-Free Architecture

The application completely avoids Flutter's traditional `setState()` approach in favor of a reactive architecture:

#### ValueNotifier-Based State Management
```dart
// Global state notifiers
static final ValueNotifier<int?> input = ValueNotifier<int?>(null);
static final ValueNotifier<List<RangeModel>> ranges = ValueNotifier<List<RangeModel>>([]);
static final ValueNotifier<bool> loading = ValueNotifier<bool>(true);
static final ValueNotifier<String?> error = ValueNotifier<String?>(null);
```

#### Reactive UI Updates
All UI components use `ValueListenableBuilder` to automatically rebuild when state changes:

```dart
ValueListenableBuilder<bool>(
  valueListenable: Notifiers.loading,
  builder: (context, loading, _) {
    if (loading) return const LoadingWidget();
    // ... rest of UI
  },
)
```

#### Benefits of This Approach
- **Predictable State**: Single source of truth for each piece of state
- **Automatic UI Updates**: UI automatically reflects state changes without manual intervention
- **Testable Logic**: Business logic can be tested independently of UI
- **Performance**: Granular rebuilds only when specific state changes

### Flutter Native Approach

The application leverages Flutter's native capabilities without external state management libraries:

#### Native Widgets Used
- `CupertinoApp` - iOS-style application shell
- `CupertinoPageScaffold` - iOS-style page structure
- `CupertinoTextField` - Native iOS-style input field
- `CupertinoButton` - iOS-style buttons
- `CupertinoActivityIndicator` - Native loading spinner
- `ValueListenableBuilder` - Built-in reactive widget for state listening

#### Custom Painting
- `CustomPainter` for drawing the range bar visualization
- Native Canvas API for efficient graphics rendering

#### Layout System
- `LayoutBuilder` for responsive design
- `Stack` and `Positioned` for absolute positioning
- Native flex widgets (`Row`, `Column`) for layout

## Data Flow

1. **Initialization**: `RangeLoader.loadRanges()` called on app start
2. **API Request**: `APIService.getRanges()` fetches data from remote endpoint
3. **State Update**: `Notifiers.ranges.value` updated with fetched data
4. **UI Reaction**: `ValueListenableBuilder` automatically rebuilds UI
5. **User Interaction**: Input field updates `Notifiers.input.value`
6. **Position Calculation**: `DimensionUtils.calculatePosition()` computes indicator position
7. **Visual Update**: Indicator widget repositions based on calculation

## Key Features

- **Real-time Input Validation**: Immediate visual feedback as users type
- **Responsive Design**: Adapts to different screen sizes using `LayoutBuilder`
- **Error Handling**: Comprehensive error states with retry functionality
- **Loading States**: User feedback during asynchronous operations
- **Accessibility**: Semantic widget structure for screen readers
- **Performance**: Efficient rendering with minimal rebuilds

## Technical Highlights

- **Zero External Dependencies**: Pure Flutter implementation without additional packages
- **Immutable Data Models**: Thread-safe data structures
- **Functional Programming**: Pure functions for calculations and transformations
- **Reactive Programming**: Event-driven architecture with automatic UI updates
- **Clean Code Principles**: Single responsibility, dependency inversion, and separation of concerns

This architecture demonstrates how to build scalable Flutter applications using native tools while maintaining clean separation between business logic and presentation layers.
