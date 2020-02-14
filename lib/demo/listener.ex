defmodule Demo.Listener do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(opts) do
    topics = opts[:topics]
    Enum.each(topics, &DemoWeb.Endpoint.subscribe(&1))
    {:ok, %{topics: topics}}
  end

  def handle_call({:unsubscribe, topic}, _from, %{topics: topics} = state) do
    if topic in topics do
      DemoWeb.Endpoint.unsubscribe(topic)
      {:reply, {:ok, topic}, Map.put(state, :topics, List.delete(topics, topic))}
    else
      {:reply, {:error, :not_subscribed}, state}
    end
  end

  def handle_call({:subscribe, topic}, _from, %{topics: topics} = state) do
    if not (topic in topics) do
      DemoWeb.Endpoint.subscribe(topic)
      {:reply, {:ok, topic}, Map.put(state, :topics, [topic | topics])}
    else
      {:reply, {:error, :already_subscribed}, state}
    end
  end

  def handle_info(event, state) do
    IO.inspect(event)
    {:noreply, state}
  end

  def subscribe(listener, topic) do
    GenServer.call(listener, {:subscribe, topic})
  end

  def unsubscribe(listener, topic) do
    GenServer.call(listener, {:unsubscribe, topic})
  end
end
