defmodule HelloApiWeb.UserController do
  use HelloApiWeb, :controller
  alias Mix.Tasks.Phx.Routes
  alias HelloApi.Users
  alias HelloApi.Users.User
  alias HelloApi.Guardian

  # def create(conn, params) do
  #   case params |> Users.create_user() do
  #     {:ok, %User{} = user} -> conn |> render("success.json", %{success: true, message: "User created!", data: user})
  #     {:error, %Ecto.Changeset{} = _changeset} -> conn |> render("error.json", %{success: false, message: "Something went wrong!", data: []})
  #   end
  # end

  def show(conn, _params) do
     user = Guardian.Plug.current_resource(conn)
     conn |> render("user.json", user: user)
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Users.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create_user(params),
      {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn |> render("jwt.json", jwt: token)
    end
  end
end
