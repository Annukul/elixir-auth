defmodule HelloApiWeb.FallbackController do
  use HelloApiWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: "Login error"})
  end
end
