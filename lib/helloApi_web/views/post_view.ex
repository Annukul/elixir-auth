defmodule HelloApiWeb.PostView do
  use HelloApiWeb, :view

  def render("posts.json", %{success: success, posts: posts}) do
     %{success: success, posts: posts}
  end

  def render("post.json", %{success: success, post: post}) do
     %{success: success, post: post}
  end

  def render("success.json", %{success: success, message: message}) do
     %{success: success, message: message}
  end

  def render("errors.json", %{errors: errors}) do
    %{success: false, errors: errors}
  end

  def render("error.json", %{error: error}) do
    %{success: false, error: error}
  end
end
