// Copyright 2021 Tokamak contributors
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
import TokamakStaticHTML

/// A Plot `Component` that displays a Tokamak `View`.
public struct ViewComponent<Content: View>: Plot.Component {
  public let content: Content
  
  public init(@ViewBuilder _ content: () -> Content) {
    self.content = content()
  }
  
  public init(_ content: Content) {
    self.content = content
  }
  
  public var body: Plot.Component {
    Plot.Node<Plot.HTML.BodyContext>.view(content)
  }
}

public extension View {
  func component() -> Plot.Component {
    ViewComponent(self)
  }
}
