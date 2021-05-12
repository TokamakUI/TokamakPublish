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

import Foundation
import Publish

public struct FoundationTokamakFactory<Site: Website>: TokamakHTMLFactory {
  public func makeIndexView(
    for index: Index,
    context: PublishingContext<Site>
  ) throws -> some View {
    Header(context: context, selectedSection: nil)
    VStack(alignment: .leading) {
      Text(index.title)
        .font(.headline)
        .bold()
        .padding(.bottom)
      Text(context.site.description)
        .font(.caption)
        .padding(.bottom)
      Text("Latest content")
        .font(.headline)
      ItemList(
        items: context.allItems(sortedBy: \.date, order: .descending),
        site: context.site
      )
    }
    .frame(idealWidth: 820, maxWidth: 820)
    .padding(.vertical, 40)
    Footer(site: context.site)
  }

  public func makeSectionView(
    for section: Publish.Section<Site>,
    context: PublishingContext<Site>
  ) throws -> some View {
    Header(context: context, selectedSection: section.id)
    Text(section.title)
      .font(.headline)
    VStack(alignment: .leading) {
      ItemList(items: section.items, site: context.site)
    }
    .frame(idealWidth: 820, maxWidth: 820)
    .padding(.vertical, 40)
    Footer(site: context.site)
  }

  public func makeItemView(
    for item: Item<Site>,
    context: PublishingContext<Site>
  ) throws -> some View {
    Header(context: context, selectedSection: item.sectionID)
    VStack(alignment: .leading) {
      item.body
      Text("Tagged with: ")
      TagList(item: item, site: context.site)
    }
    .frame(idealWidth: 820, maxWidth: 820)
    .padding(.vertical, 40)
    Footer(site: context.site)
  }

  public func makePageView(
    for page: Page,
    context: PublishingContext<Site>
  ) throws -> some View {
    Header(context: context, selectedSection: nil)
    VStack(alignment: .leading) {
      page.body
    }
    .frame(idealWidth: 820, maxWidth: 820)
    .padding(.vertical, 40)
    Footer(site: context.site)
  }

  public func makeTagListView(
    for page: TagListPage,
    context: PublishingContext<Site>
  ) throws -> some View
  {
    Header(context: context, selectedSection: nil)
    VStack(alignment: .leading) {
      Text("Browse all tags")
        .font(.headline)
      HStack {
        ForEach(page.tags.sorted()) { tag in
          Tag(tag: tag, site: context.site)
        }
      }
    }
    .frame(idealWidth: 820, maxWidth: 820)
    .padding(.vertical, 40)
    Footer(site: context.site)
  }

  public func makeTagDetailsView(
    for page: TagDetailsPage,
    context: PublishingContext<Site>
  ) throws -> some View {
    Header(context: context, selectedSection: nil)
    VStack(alignment: .leading) {
      HStack {
        Text("Tagged with")
          .padding(.trailing)
        Tag(tag: page.tag, site: context.site)
      }
      .font(.headline)
      Link(
        "Browse all tags",
        destination: URL(string: context.site.tagListPath.absoluteString)!
      )
      ItemList(
        items: context.items(
          taggedWith: page.tag,
          sortedBy: \.date,
          order: .descending
        ),
        site: context.site
      )
    }
    .frame(idealWidth: 820, maxWidth: 820)
    .padding(.vertical, 40)
    Footer(site: context.site)
  }
}
