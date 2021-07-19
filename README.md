# CmarkNative

A proof-of-concept, drop-in replacement for [cmark.ex](https://github.com/asaaki/cmark.ex) that uses pre-compiled binaries.

## Usage

```elixir
iex> Mix.install([{:cmark_native, github: "wojtekmach/cmark_native", sparse: "cmark_native"}])
iex> Cmark.to_html("*Hello*")
"<p><em>Hello</em></p>\n"
```

## How it works

This repository contains the CmarkNative:

  * [`cmark_native`](cmark_native)

as well as a package for each supported target:

  * [`cmark_native_darwin_aarch64`](cmark_native_darwin_aarch64)
  * [`cmark_native_darwin_x86_64`](cmark_native_darwin_x86_64)
  * [`cmark_native_linux_aarch64`](cmark_native_linux_aarch64)
  * [`cmark_native_linux_x86_64`](cmark_native_linux_x86_64)

Each target package contains the shared library, e.g.: <https://github.com/wojtekmach/cmark_native/blob/main/cmark_native_darwin_aarch64/priv/cmark.so>.

This setup works when `cmark_native` is used as a Git dependency. In that scenario, the dependencies look like this:

```
# cmark_native/mix.exs
defp deps do
  Mix.target(...)

  {:cmark_native, github: "wojtekmach/cmark_native_darwin_aarch64", targets: [:darwin_aarch64]},
  {:cmark_native, github: "wojtekmach/cmark_native_darwin_x86_64", targets: [:darwin_x86_64]},
  {:cmark_native, github: "wojtekmach/cmark_native_linux_aarch64", targets: [:linux_aarch64]},
  {:cmark_native, github: "wojtekmach/cmark_native_linux_x86_64", targets: [:linux_x86_64]}
end
```

Mix would fetch `cmark_native`, look at the dependencies, and only pick target specific package to fetch next.

Unfortunately this approach would not work when publishing to Hex at the moment. We'd end up with this:

```elixir
# cmark_native/mix.exs
defp deps do
  {:cmark_native, ">= 0.0.0", targets: [:darwin_aarch64]},
  {:cmark_native, ">= 0.0.0", targets: [:darwin_x86_64]},
  {:cmark_native, ">= 0.0.0", targets: [:linux_aarch64]},
  {:cmark_native, ">= 0.0.0", targets: [:linux_x86_64]}
end
```

However Hex does not have support for Mix targets. It would simply make it so `cmark_native` depends on all of these which is not what we want.

## License

CmarkNative

Copyright (c) 2021 Wojtek Mach

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

cmark.ex

- Cmark.ex: <https://github.com/asaaki/cmark.ex/blob/main/LICENSE> (MIT)
- cmark (C): <https://github.com/asaaki/cmark.ex/blob/main/c_src/COPYING> (multiple)
