defmodule HelloApiWeb.PostController do
  use HelloApiWeb, :controller
  alias HelloApi.Posts
  alias HelloApi.Posts.Post
  alias HelloApiWeb.Utils

  def get_all(conn, _params) do
    conn
    |> render("posts.json", %{success: true, posts: Posts.list_posts()})
  end

  def create(conn, params) do
    res = params |> Posts.create_post()
    IO.inspect(res)
    case res do
      {:ok, %Post{} = _post} -> conn |> render("success.json", %{success: true, message: "Post created!"})
      {:error, %Ecto.Changeset{} = changeset} -> conn |> render("errors.json", %{errors: Utils.format_changeset_errors(changeset)})
      _ -> conn |> render("error", %{error: Utils.internal_server_error()})
    end
  end

  def get_one(conn, %{"id" => id}) do
    conn
    |> render("post.json", %{success: true, post: Posts.get_post!(id)})
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    deleted = Posts.delete_post(post)
    case deleted do
      {:ok, %Post{} = _post} -> conn |> render("success.json", %{success: true, message: "Post deleted!"})
      {:error, %Ecto.Changeset{} = changeset} -> conn |> render("errors.json", %{errors: Utils.format_changeset_errors(changeset)})
      _ -> conn |> render("error", %{error: Utils.internal_server_error()})
    end
  end

   def update(conn, %{"id" => id} = params) do
    post = Posts.get_post!(id)
    updated = Posts.update_post(post, params)
    case updated do
      {:ok, %Post{} = _post} -> conn |> render("success.json", %{success: true, message: "Post updated!"})
      {:error, %Ecto.Changeset{} = _changeset} -> conn |> render("success.json", %{success: false, message: "Post not found!"})
    end
  end
end
