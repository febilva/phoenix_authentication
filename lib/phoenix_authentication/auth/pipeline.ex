defmodule PhoenixAuthentication.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :auth_ex,
    error_handler: PhoenixAuthentication.Auth.ErrorHandler,
    module: PhoenixAuthentication.Auth.Guardian

  plug Guardian.Plug.VerifySession

  plug Guardian.Plug.EnsureAuthenticated

  plug Guardian.Plug.LoadResource
end