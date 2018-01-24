defmodule PhoenixAuthentication.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixAuthentication.Accounts.User


  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
  end
end
