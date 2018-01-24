defmodule PhoenixAuthenticationWeb.PageController do
  use PhoenixAuthenticationWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
