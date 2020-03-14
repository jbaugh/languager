defmodule Languager.Services.Authenticator do
  # These values must be moved in a configuration file
  @seed "user token"# good way to generate: 
  # :crypto.strong_rand_bytes(30) 
  # |> Base.url_encode64 
  # |> binary_part(0, 30)
  @secret "CHANGE_ME_k7kTxvFAgeBvAVA0OR1vkPbTi8mZ5m"
   def generate_token(id) do
    Phoenix.Token.sign(@secret, @seed, id, max_age: 86400)
  end 

  def verify_token(token) do
    case Phoenix.Token.verify(@secret, @seed, token, max_age: 86400) do
      {:ok, id} -> {:ok, token}
      error -> error
    end
  end
end
