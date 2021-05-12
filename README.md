# TokamakPublish

Use Tokamak in your themes for [the Publish static generator](https://github.com/johnsundell/Publish).

You can either write your entire theme with Tokamak, or integrate it with your existing `Plot` HTML.

A Tokamak implementation of the `.foundation` theme is provided under the name `.tokamakFoundation`.

## `TokamakHTMLFactory`

To make your own Tokamak theme, conform to the `TokamakHTMLFactory` protocol. That requires the following functions:

```swift
struct MyThemeFactory<Site: Website>: TokamakHTMLFactory {
  func makeIndexView(for index: Index, context: PublishingContext<Self.Site>) throws -> IndexView
  func makeSectionView(
    for section: Publish.Section<Self.Site>,
    context: PublishingContext<Self.Site>
  ) throws -> SectionView
  func makeItemView(for item: Item<Self.Site>, context: PublishingContext<Self.Site>) throws -> ItemView
  func makePageView(for page: Page, context: PublishingContext<Self.Site>) throws -> PageView
  func makeTagListView(for page: TagListPage, context: PublishingContext<Self.Site>) throws -> TagListView
  func makeTagDetailsView(for page: TagDetailsPage, context: PublishingContext<Self.Site>) throws -> TagDetailsView
}
```

In these functions, you can build a `View` with SwiftUI-compatible syntax:

```swift
struct MyThemeFactory<Site: Website>: TokamakHTMLFactory {
  func makePageView(for page: Page, context: PublishingContext<Self.Site>) throws -> PageView {
    Text("Welcome to my website")
      .font(.largeTitle)
    VStack(alignment: .leading) {
      page.body
    }
      .frame(idealWidth: 820, maxWidth: 820)
      .padding(.vertical, 40)
    Text("2020 © Tokamak Contributors")
      .font(.caption)
  }
  ...
}
```

## Plot integration

TokamakPublish integrates with both the `Component` and `Node` APIs.

### Component API

You can use any `View` inside of a `Component` body with `ViewComponent`:

```swift
struct Header: Component {
  var body: Component {
    H1("My Website")
    Text("This is a Tokamak ") + Text("View")
      .font(.system(.body, design: .monospaced))
    ViewComponent(MyTokamakView())
  }
}
```

And vice-versa with `ComponentView`:

```swift
struct ContentView: View {
  var body: some View {
    Text("My Website")
      .font(.largeTitle)
    ComponentView(Header())
  }
}
```

There are also modifiers to convert from one to the other:
```swift
Header().view() // Component -> View
ContentView().component() // View -> Component
```

### Node API

You can include Tokamak views in your Plot HTML with the `view` Node:

```swift
let myHTML = Plot.HTML(
  .body(
    .h1(.text("My Website")),
    .view {
      Text("This is a Tokamak ") + Text("View")
        .font(.system(.body, design: .monospaced))
    },
    .view(MyTokamakView())
  )
)
```

You can include Plot nodes in your Tokamak views just as easily:

```swift
struct ContentView: View {
  var body: some View {
    Text("My Website")
      .font(.largeTitle)
    Node.p(
      .span("This is a Plot "),
      .span(.text("Node"), .style("font-family: monospace"))
    )
  }
}
```
