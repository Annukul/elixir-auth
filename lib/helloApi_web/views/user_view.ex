defmodule HelloApiWeb.UserView do
  use HelloApiWeb, :view

  def render("show.json", %{user: user}) do
     %{user: user}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("user.json", %{user: user}) do
    %{user: user}
  end

  def render("error.json", %{success: success, message: message, data: data}) do
    %{success: success, message: message, data: data}
  end
end
