defmodule Languager.Services.Authenticator do
  @seed "user token" 
  @secret Application.get_env(:languager, :authenticator_secret)

  def generate_token(id) do
    Phoenix.Token.sign(@secret, @seed, id, max_age: 86400)
  end 

  def verify_token(token) do
    case Phoenix.Token.verify(@secret, @seed, token, max_age: 86400) do
      {:ok, id} -> {:ok, id}
      error -> error
    end
  end

  def delete_token(conn) do
    case Languager.Services.Authenticator.get_auth_token(conn) do
      {:ok, token} ->
        case Languager.Repo.get_by(Languager.Accounts.AuthToken, %{token: token}) do
          nil -> {:error, :not_found}
          auth_token -> Languager.Repo.delete(auth_token)
        end
      error -> error
    end
  end

  def get_auth_token(conn) do
    case extract_token(conn) do
      {:ok, token} -> verify_token(token)
      error -> error
    end
  end

  defp extract_token(conn) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      [auth_header] -> get_token_from_header(auth_header)
       _ -> {:error, :missing_auth_header}
    end
  end

  defp get_token_from_header(auth_header) do
    {:ok, reg} = Regex.compile("Bearer\:?\s+(.*)$", "i")
    case Regex.run(reg, auth_header) do
      [_, match] -> {:ok, String.trim(match)}
      _ -> {:error, "token not found"}
    end
  end
end
