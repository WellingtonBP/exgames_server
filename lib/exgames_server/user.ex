defmodule ExgamesServer.User do
  use Ecto.Schema
  import Ecto.Changeset

  @email_regex ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field :name, :string
    field :email, :string
    field :avatar_url, :string
    field :birthday, :date
    field :hashed_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(user = %__MODULE__{}, attrs) do
    user
    |> cast(attrs, [:name, :email, :avatar_url, :birthday, :birthday, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:name)
    |> unique_constraint(:email)
    |> validate_format(:email, @email_regex, message: "invalid email format")
    |> validate_length(:password, min: 8, max: 32)
    |> hash_password()
  end

  defp hash_password(changeset) do
    changeset
    |> get_change(:password)
    |> then(&put_change(changeset, :hashed_password, Bcrypt.hash_pwd_salt(&1)))
  end

  def translate_errors(%Ecto.Changeset{valid?: false, errors: errors}) do
    errors
    |> Map.new(fn {key, {message, meta}} ->
      {key, interpolation(message, meta)}
    end)
  end

  def translate_errors(_), do: nil

  defp interpolation(message, meta) do
    meta
    |> Enum.reduce(message, fn {key, value}, message ->
      message
      |> String.replace("%{#{key}}", to_string(value))
    end)
  end
end
