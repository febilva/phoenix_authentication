defmodule PhoenixAuthentication.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixAuthentication.Accounts.User


  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :hashed_password])
    |> validate_required([:name, :email, :hashed_password])
    |> unique_constraint(:email)
  end
end
