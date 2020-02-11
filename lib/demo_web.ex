defmodule DemoWeb do
  @moduledoc """
  The entrypoint for defining your web interface
  """

  def router do
    quote do
      use Plug.ErrorHandler
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
