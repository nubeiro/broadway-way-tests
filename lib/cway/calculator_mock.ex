defmodule Cway.CalculatorMock do
  @behaviour Cway.Calculator

  @impl true
  def compute(_number), do: 4
end
