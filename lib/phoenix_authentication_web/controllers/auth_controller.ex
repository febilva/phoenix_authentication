defmodule PhoenixAuthenticationWeb.AuthController do
  use PhoenixAuthenticationWeb, :controller

  alias PhoenixAuthentication.Accounts
  alias PhoenixAuthentication.Auth.Guardian

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_by_email_password(email, password) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: secret_garden_path(conn, :index))
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Bad email/password combination")
        |> redirect(to: auth_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/")
  end
end
