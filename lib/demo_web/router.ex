defmodule DemoWeb.Router do
  use DemoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DemoWeb do
    pipe_through :api
  end

  def handle_errors(conn, _) do
    conn
    |> send_resp(Plug.Conn.Status.code(:not_found), "Not found")
  end
end
