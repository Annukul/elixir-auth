defmodule HelloApi.Repo do
  use Ecto.Repo,
    otp_app: :helloApi,
    adapter: Ecto.Adapters.Postgres
end
