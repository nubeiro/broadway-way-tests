defmodule Cway.MultiplyCalculator do
  @behaviour Cway.Calculator

  @impl Cway.Calculator
  def compute(number) do
    number * 2
  end
end
