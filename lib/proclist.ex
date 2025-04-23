defmodule Proclist do
  @moduledoc """
  A wrapper around the `proclist` Rust crate which provides a list of operating system processes.
  """
  use Rustler, otp_app: :proclist, crate: :proclist, target: System.get_env("RUSTLER_TARGET")

  @doc """
  Return a list of all processes currently running on the host operating system.
  """
  @spec all_processes :: [Proclist.Process.t()]
  def all_processes, do: :erlang.nif_error(:not_loaded)
end
