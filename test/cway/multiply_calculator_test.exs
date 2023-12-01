defmodule Cway.MultiplyCalculatorTest do
  use ExUnit.Case, async: true
  use Hammox.Protect, module: Cway.MultiplyCalculator, behaviour: Cway.Calculator

  test "compute/1 returns number multiplied by 2" do
    assert {:ok, 4} == compute(2)
  end
end
