defmodule HelloApi.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  @derive {Jason.Encoder, only: [:email, :name]}
  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    # Virtual fields:
    field :password_virtual, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_virtual, :password_confirmation])
    |> validate_required([:name, :email, :password_virtual, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password_virtual, min: 8)
    |> validate_confirmation(:password_virtual)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  def put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password_virtual: pass}} -> put_change(changeset, :password, hashpwsalt(pass))
      _ -> changeset
    end
  end
end
