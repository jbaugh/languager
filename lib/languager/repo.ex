defmodule Languager.Repo do
  use Ecto.Repo,
    otp_app: :languager,
    adapter: Ecto.Adapters.Postgres
end
