defmodule Proclist.Process do
  @moduledoc """
  A struct which represents information about an operating system process.
  """

  defstruct name: nil, pid: 0, parent_pid: 0, threads_count: 0

  @type t :: %__MODULE__{
          name: String.t(),
          pid: pos_integer(),
          parent_pid: non_neg_integer(),
          threads_count: pos_integer()
        }
end
