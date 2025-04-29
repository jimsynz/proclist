defmodule Proclist.Monitor do
  @moduledoc """
  A wrapper around the `cnproc` Rust crate which provides events about Linux processes.
  """
  use Rustler,
    otp_app: :proclist,
    crate: :procmon,
    target: System.get_env("RUSTLER_TARGET")

  def start, do: :erlang.nif_error(:not_loaded)
end
