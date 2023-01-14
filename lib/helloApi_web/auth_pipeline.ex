defmodule HelloApi.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :helloApi,
  module: HelloApi.Guardian,
  error_handler: HelloApi.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
