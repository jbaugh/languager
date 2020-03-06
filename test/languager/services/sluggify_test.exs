defmodule Languager.Services.SluggifyTest do
  use Languager.DataCase
  alias Languager.Accounts.User

  @user_attrs %{email: "someemail@example.com", password: "123123"}

  test "sluggify with no base value" do
    changeset = User.changeset(%User{}, @user_attrs)
    new_changeset = Languager.Services.Sluggify.sluggify(changeset, User)
    assert new_changeset.changes[:external_id] != nil
  end

  test "sluggify with base value" do
    changeset = User.changeset(%User{}, @user_attrs)
    new_changeset = Languager.Services.Sluggify.sluggify(changeset, User, :email)
    assert new_changeset.changes[:external_id] != nil
    assert new_changeset.changes[:external_id] =~ "someemail"
  end
end
