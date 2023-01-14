defmodule HelloApi.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelloApi.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        category: "some category",
        desc: "some desc",
        dislikes: 42,
        excerpt: "some excerpt",
        likes: 42,
        title: "some title"
      })
      |> HelloApi.Posts.create_post()

    post
  end
end
