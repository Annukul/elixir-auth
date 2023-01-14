defmodule HelloApi.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "posts" do
    field :category, :string
    field :desc, :string
    field :dislikes, :integer
    field :excerpt, :string
    field :likes, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :excerpt, :desc, :category, :likes, :dislikes])
    |> validate_required([:title, :excerpt, :desc, :category, :likes, :dislikes])
  end
end
