# NIF for Proclist

## To build the NIF module:

- Your NIF will now build along with your project.

## To load the NIF:

```elixir
defmodule Proclist do
  use Rustler, otp_app: :proclist, crate: "proclist"
end
```

## Examples

[This](https://github.com/rusterlium/NifIo) is a complete example of a NIF written in Rust.
