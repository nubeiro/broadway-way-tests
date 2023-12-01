defmodule NumbersPipelineTest do
  use ExUnit.Case, async: false
  import Mox
  setup :set_mox_global
  setup :verify_on_exit!

  test "test message" do
    expected_number = 4
    expect(Cway.CalculatorMock, :compute, fn _ -> expected_number end)

    ref = Broadway.test_message(NumbersPipeline, "1")

    assert_receive {:ack, ^ref, [%{data: {"1", ^expected_number}}], []}
  end
end
