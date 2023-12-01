defmodule Cway.Calculator do
  @moduledoc """
  This module implements the calculator behaviour.
  """
  @callback compute(integer) :: integer

  def compute(number), do: impl().compute(number)

  defp impl(), do: Application.get_env(:cway, :calculator_module)
end
