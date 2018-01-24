defmodule PhoenixAuthenticationWeb.LayoutView do
  use PhoenixAuthenticationWeb, :view

  def current_user_exists(conn) do
    Map.get(conn.assigns, :current_user, nil) != nil
  end
end
