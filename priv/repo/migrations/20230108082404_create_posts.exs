defmodule HelloApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :excerpt, :string
      add :desc, :text
      add :category, :string
      add :likes, :integer
      add :dislikes, :integer

      timestamps()
    end
  end
end
