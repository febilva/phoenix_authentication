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
  def update_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email], [:password])
    |> validate_required([:name, :email])
    |> put_pass_hash
    |> unique_constraint(:email)
  end

  @doc false
  def registration_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> put_pass_hash
    |> unique_constraint(:email)
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
