defmodule HelloApi.PostsTest do
  use HelloApi.DataCase

  alias HelloApi.Posts

  describe "posts" do
    alias HelloApi.Posts.Post

    import HelloApi.PostsFixtures

    @invalid_attrs %{category: nil, desc: nil, dislikes: nil, excerpt: nil, likes: nil, title: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{category: "some category", desc: "some desc", dislikes: 42, excerpt: "some excerpt", likes: 42, title: "some title"}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.category == "some category"
      assert post.desc == "some desc"
      assert post.dislikes == 42
      assert post.excerpt == "some excerpt"
      assert post.likes == 42
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{category: "some updated category", desc: "some updated desc", dislikes: 43, excerpt: "some updated excerpt", likes: 43, title: "some updated title"}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.category == "some updated category"
      assert post.desc == "some updated desc"
      assert post.dislikes == 43
      assert post.excerpt == "some updated excerpt"
      assert post.likes == 43
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
