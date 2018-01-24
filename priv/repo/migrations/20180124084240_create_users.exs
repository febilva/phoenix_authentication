defmodule PhoenixAuthentication.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password_hash, :string, null: true

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
