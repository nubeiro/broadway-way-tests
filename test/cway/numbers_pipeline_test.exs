defmodule NumbersPipelineTest do
  use ExUnit.Case, async: false
  import Hammox
  setup :set_mox_global
  setup :verify_on_exit!

  test "test message" do
    expected_number = 2
    expect(Cway.MockedFixedCalculator, :compute, fn _ -> {:ok, expected_number} end)

    ref = Broadway.test_message(NumbersPipeline, "1")

    assert_receive {:ack, ^ref, [%{data: {"1", {:ok, ^expected_number}}}], []}
  end
end
