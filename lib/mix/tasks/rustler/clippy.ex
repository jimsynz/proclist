defmodule Mix.Tasks.Rustler.Clippy do
  use Mix.Task

  alias Mix.Shell.IO

  def run(_) do
    result =
      "native/*"
      |> Path.wildcard()
      |> Enum.filter(&File.dir?/1)
      |> Enum.map(&Path.basename/1)
      |> Enum.reduce(0, fn crate, result ->
        exit_code =
          "cargo clippy"
          |> IO.cmd(cd: "native/#{crate}", env: %{"RUSTFLAGS" => "-Dwarnings"})

        if exit_code > 0 do
          IO.error("`cargo clippy` failed for rustler crate `#{crate}`")
        end

        result + exit_code
      end)

    if result > 0 do
      System.at_exit(fn _ -> exit({:shutdown, result}) end)
    end
  end
end
