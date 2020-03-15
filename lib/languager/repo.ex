defmodule Languager.Repo do
  use Ecto.Repo,
    otp_app: :languager,
    adapter: Ecto.Adapters.Postgres


  def get(query) do
    case Languager.Repo.one(query) do
      nil -> {:error, :not_found}
      val -> {:ok, val}
    end
  end
end
