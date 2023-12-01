defmodule CwayWeb.Router do
  use CwayWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CwayWeb do
    pipe_through :api
  end
end
