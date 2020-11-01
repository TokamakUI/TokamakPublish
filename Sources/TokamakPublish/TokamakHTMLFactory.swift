// Copyright 2020 Tokamak contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Plot
import Publish

public protocol TokamakHTMLFactory: HTMLFactory {
  associatedtype IndexView: View
  /// Create the `View` to use for the website's main index page.
  /// - parameter index: The index page to build a `View` for.
  /// - parameter context: The current publishing context.
  @ViewBuilder
  func makeIndexView(for index: Index, context: PublishingContext<Self.Site>) throws -> IndexView

  associatedtype SectionView: View
  /// Create the `View` to use for the index page of a section.
  /// - parameter section: The section to build a `View` for.
  /// - parameter context: The current publishing context.
  @ViewBuilder
  func makeSectionView(
    for section: Publish.Section<Self.Site>,
    context: PublishingContext<Self.Site>
  ) throws -> SectionView

  associatedtype ItemView: View
  /// Create the `View` to use for an item.
  /// - parameter item: The item to build a `View` for.
  /// - parameter context: The current publishing context.
  @ViewBuilder
  func makeItemView(for item: Item<Self.Site>, context: PublishingContext<Self.Site>) throws
    -> ItemView

  associatedtype PageView: View
  /// Create the `View` to use for a page.
  /// - parameter page: The page to build a `View` for.
  /// - parameter context: The current publishing context.
  @ViewBuilder
  func makePageView(for page: Page, context: PublishingContext<Self.Site>) throws -> PageView

  associatedtype TagListView: View
  /// Create the `View` to use for the website's list of tags, if supported.
  /// Return `EmptyView` if the theme that this factory is for doesn't support tags.
  /// - parameter page: The tag list page to build a `View` for.
  /// - parameter context: The current publishing context.
  @ViewBuilder
  func makeTagListView(for page: TagListPage, context: PublishingContext<Self.Site>) throws
    -> TagListView

  associatedtype TagDetailsView: View
  /// Create the `View` to use for a tag details page, used to represent a single
  /// tag. Return `EmptyView` if the theme that this factory is for doesn't support tags.
  /// - parameter page: The tag details page to build a `View` for.
  /// - parameter context: The current publishing context.
  @ViewBuilder
  func makeTagDetailsView(for page: TagDetailsPage, context: PublishingContext<Self.Site>) throws
    -> TagDetailsView
}

public extension TokamakHTMLFactory {
  func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> Plot
    .HTML
  {
    let content = try makeIndexView(for: index, context: context)
    return .init(.view(ScrollView { content }.frame(minWidth: 0, maxWidth: .infinity)))
  }

  func makeSectionHTML(
    for section: Publish.Section<Site>,
    context: PublishingContext<Site>
  ) throws -> Plot.HTML {
    let content = try makeSectionView(for: section, context: context)
    return .init(.view(ScrollView { content }.frame(minWidth: 0, maxWidth: .infinity)))
  }

  func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> Plot
    .HTML
  {
    let content = try makeItemView(for: item, context: context)
    return .init(.view(ScrollView { content }.frame(minWidth: 0, maxWidth: .infinity)))
  }

  func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> Plot.HTML {
    let content = try makePageView(for: page, context: context)
    return .init(.view(ScrollView { content }.frame(minWidth: 0, maxWidth: .infinity)))
  }

  func makeTagListHTML(for page: TagListPage,
                       context: PublishingContext<Site>) throws -> Plot.HTML?
  {
    let content = try makeTagListView(for: page, context: context)
    return .init(.view(ScrollView { content }.frame(minWidth: 0, maxWidth: .infinity)))
  }

  func makeTagDetailsHTML(for page: TagDetailsPage,
                          context: PublishingContext<Site>) throws -> Plot.HTML?
  {
    let content = try makeTagDetailsView(for: page, context: context)
    return .init(.view(ScrollView { content }.frame(minWidth: 0, maxWidth: .infinity)))
  }
}

extension Publish.Content.Body: View {
  public var body: some View {
    TokamakStaticHTML.HTML("div", content: html)
  }
}

extension Publish.Item: Identifiable {
  public var id: String {
    path.absoluteString
  }
}

extension Publish.Tag: Identifiable {
  public var id: String {
    string
  }
}

public extension Theme {
  static var tokamakFoundation: Self {
    Theme(htmlFactory: FoundationTokamakFactory())
  }
}
