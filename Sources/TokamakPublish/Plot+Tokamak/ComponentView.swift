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

/// A Tokamak `View` that displays a Plot `Component`.
public struct ComponentView: View {
  public let component: Plot.Component
  
  public init(@Plot.ComponentBuilder _ component: () -> Plot.Component) {
    self.component = component()
  }
  
  public init(_ component: Plot.Component) {
    self.component = component
  }
  
  public var body: some View {
    Plot.Node<Plot.HTML.BodyContext>.component(component)
  }
}

public extension Component {
  func view() -> some View {
    ComponentView(self)
  }
}
