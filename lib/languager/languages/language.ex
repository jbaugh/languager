defmodule Languager.Languages.Language do
  use Ecto.Schema
  import Ecto.Changeset

  schema "languages" do
    field :name, :string
    field :active, :boolean, default: true
    field :external_id, :string

    timestamps()
  end

  @doc false
  def changeset(language, attrs) do
    language
    |> cast(attrs, [:name, :active])
    |> validate_required([:name])
    |> Languager.Services.Sluggify.sluggify(Languager.Languages.Language, :name)
  end
end
