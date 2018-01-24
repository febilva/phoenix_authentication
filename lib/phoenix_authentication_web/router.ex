defmodule PhoenixAuthenticationWeb.Router do
  use PhoenixAuthenticationWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixAuthenticationWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController
    
    get "/login", AuthController, :new
    post "/login", AuthController, :create

  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixAuthenticationWeb do
  #   pipe_through :api
  # end
end
