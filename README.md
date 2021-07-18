# CmarkNative

A proof-of-concept, drop-in replacement for [cmark.ex](https://github.com/asaaki/cmark.ex) that uses pre-compiled binaries.

## Usage

```elixir
iex> Mix.install([{:cmark_native, github: "wojtekmach/cmark_native"}])
iex> Cmark.to_html("*Hello*")
"<p><em>Hello</em></p>\n"
```

## How it works

This repository contains the CmarkNative package itself as well as a package for each supported target:

  * [`packages/cmark_native_darwin_aarch64`](packages/cmark_native_darwin_aarch64)
  * [`packages/cmark_native_darwin_x86_64`](packages/cmark_native_darwin_x86_64)
  * [`packages/cmark_native_linux_aarch64`](packages/cmark_native_linux_aarch64)
  * [`packages/cmark_native_linux_x86_64`](packages/cmark_native_linux_x86_64)

Each target package contains the shared library, e.g.: <https://github.com/wojtekmach/cmark_native/blob/main/packages/cmark_native_darwin_aarch64/priv/cmark.so>.

When building `cmark_native` package, we simply pick the correct Mix target: <https://github.com/wojtekmach/cmark_native/blob/main/mix.exs#L1>.

If we start publishing this to Hex we'd probably keep the monorepo:

    ./
      cmark_native/
      cmark_native_darwin_aarch64/
      cmark_native_darwin_x86_64/
      cmark_native_linux_aarch64/
      cmark_native_linux_x86_64/

but of course publish each piece as a separate Hex package.

## License

CmarkNative

Copyright (c) 2021 Wojtek Mach

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

cmark.ex

- Cmark.ex: <https://github.com/asaaki/cmark.ex/blob/main/LICENSE> (MIT)
- cmark (C): <https://github.com/asaaki/cmark.ex/blob/main/c_src/COPYING> (multiple)
