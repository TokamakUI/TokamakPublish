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
import TokamakStaticHTML

public extension Plot.Node {
  static func view<V>(_ view: V) -> Self where V: View {
    .raw(StaticHTMLRenderer(view).html)
  }

  static func view<V>(@ViewBuilder _ body: () -> V) -> Self
    where V: View
  {
    .raw(StaticHTMLRenderer(body()).html)
  }
}

extension Plot.Node: View, AnyHTML where Context == Plot.HTML.BodyContext {
  public var innerHTML: String? {
    render()
  }

  public var tag: String {
    "div"
  }

  public var attributes: [HTMLAttribute: String] {
    [:]
  }

  public var body: Never {
    fatalError("Plot Nodes should be evaluated as HTML. This is a bug.")
  }
}
