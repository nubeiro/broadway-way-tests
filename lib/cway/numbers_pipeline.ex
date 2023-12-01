defmodule NumbersPipeline do
  use Broadway

  alias Broadway.Message

  def start_link(opts) do
    producer_module = Keyword.get(opts, :producer_module)
    producer_options = Keyword.get(opts, :producer_options)
    calculator_module = Keyword.get(opts, :calculator_module)

    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {producer_module, producer_options},
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 50
        ]
      ],
      batchers: [
        default: [
          batch_size: 10,
          batch_timeout: 1500,
          concurrency: 5
        ]
      ],
      context: [calculator_module: calculator_module]
    )
  end

  @impl true
  def handle_message(_processor, message, context) do
    logic = context[:calculator_module]

    message
    |> Message.update_data(fn data -> {data, String.to_integer(data) |> logic.compute()} end)
  end

  @impl true
  def handle_batch(_batcher, messages, _batch_info, _context) do
    messages
    |> Enum.map(fn e -> e.data end)
    |> IO.inspect(label: "Got batch")

    messages
  end
end
