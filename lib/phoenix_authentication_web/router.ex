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

    get "/register", UserController, :new
    post "/register", UserController, :create
    
    get "/login", AuthController, :new
    post "/login", AuthController, :create
  end

  scope "/", PhoenixAuthenticationWeb do
    pipe_through [:browser, :authenticate_user]

    delete "/logout", AuthController, :delete

    resources "/me", UserController, only: [:show, :edit, :update], singleton: true
    
    get "/secretgarden", SecretGardenController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixAuthenticationWeb do
  #   pipe_through :api
  # end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        redirect_login_required(conn)
      user_id ->
        case PhoenixAuthentication.Accounts.get_user(user_id) do
          nil ->
            redirect_login_required(conn)
          %PhoenixAuthentication.Accounts.User{} = user ->
            assign(conn, :current_user, user)
        end
    end
  end

  defp redirect_login_required(conn) do
    conn
    |> Phoenix.Controller.put_flash(:error, "Login required")
    |> Phoenix.Controller.redirect(to: "/")
    |> halt()
  end
end
