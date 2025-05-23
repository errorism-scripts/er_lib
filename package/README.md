# er_lib JS/TS wrapper

Not all er_lib functions found in Lua are supported, the ones that are will have a JS/TS example
on the documentation.

You still need to use and have the er_lib resource included into the resource you are using the npm package in.

But in THIS fork new feature will be added only in lua, so we recommend to use the ox_lib original version

## Installation

```yaml
# With pnpm
pnpm add @overextended/ox_lib

# With Yarn
yarn add @overextended/ox_lib

# With npm
npm install @overextended/ox_lib
```

## Usage
You can either import the lib from client or server files or deconstruct the object and import only certain functions
you may require.

```ts
import lib from '@overextended/ox_lib/client'
```

```ts
import lib from '@overextended/ox_lib/server'
```

```ts
import { checkDependency } from '@overextended/ox_lib/shared';
```

## Documentation
[View documentation](https://overextended.github.io/docs/ox_lib)
