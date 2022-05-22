defmodule ExgamesServerWeb.Auth.Guardian do
  use Guardian, otp_app: :exgames_server

  alias ExgamesServer.Repo
  alias ExgamesServer.User

  def subject_for_token(subject, _claims), do: {:ok, subject}

  def resource_from_claims(%{"sub" => id}), do: id

  def resource_from_claims(_claims), do: {:error, :invalid_jwt_claims}

  def authenticate(%{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, :user_not_found}

      %User{hashed_password: hashed_password, id: id} ->
        password
        |> Bcrypt.verify_pass(hashed_password)
        |> create_token(id)
    end
  end

  def authenticate(_), do: {:error, :invalid_params}

  defp create_token(true, sub) do
    {:ok, token, _claims} = encode_and_sign(sub, %{}, ttl: {24, :hours})

    {:ok, token}
  end

  defp create_token(false, _sub), do: {:error, :invalid_password}
end
