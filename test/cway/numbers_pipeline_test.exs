defmodule NumbersPipelineTest do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  test "test message" do
    ref = Broadway.test_message(NumbersPipeline, "1")
    assert_receive {:ack, ^ref, [%{data: {"1", 4}}], []}
  end
end
