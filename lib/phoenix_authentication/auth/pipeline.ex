defmodule PhoenixAuthentication.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :phoenix_authentication,
    error_handler: PhoenixAuthentication.Auth.ErrorHandler,
    module: PhoenixAuthentication.Auth.Guardian

  plug Guardian.Plug.VerifySession

  plug Guardian.Plug.EnsureAuthenticated

  plug Guardian.Plug.LoadResource
end