defmodule Languager.AccountsTest do
  use Languager.DataCase
  alias Languager.Accounts

  describe "users" do
    alias Languager.Accounts.User

    @valid_attrs %{email: "someemail@example.com", name: "Smith", password: "some password", external_id: "some external_id"}
    @update_attrs %{email: "newsomeemail@example.com", name: "Foo", password: "some updated password", external_id: "some updated external_id"}
    @invalid_attrs %{email: nil, encrypted_password: nil, external_id: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "someemail@example.com"
      assert user.name == "Smith"
      assert user.external_id =~ "someemail"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.name == "Foo"
    end

    # test "update_user/2 with invalid data returns error changeset" do
    #   user = user_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
    #   assert user == Accounts.get_user!(user.id)
    # end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "auth_tokens" do
    alias Languager.Accounts.AuthToken

    @valid_attrs %{token: "some token"}
    @update_attrs %{token: "some updated token"}
    @invalid_attrs %{token: nil}

    def auth_tokens_fixture(attrs \\ %{}) do
      {:ok, auth_tokens} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_auth_tokens()

      auth_tokens
    end

    test "list_auth_tokens/0 returns all auth_tokens" do
      auth_tokens = auth_tokens_fixture()
      assert Accounts.list_auth_tokens() == [auth_tokens]
    end

    test "get_auth_tokens!/1 returns the auth_tokens with given id" do
      auth_tokens = auth_tokens_fixture()
      assert Accounts.get_auth_tokens!(auth_tokens.id) == auth_tokens
    end

    test "create_auth_tokens/1 with valid data creates a auth_tokens" do
      assert {:ok, %AuthToken{} = auth_tokens} = Accounts.create_auth_tokens(@valid_attrs)
      assert auth_tokens.token == "some token"
    end

    test "create_auth_tokens/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_auth_tokens(@invalid_attrs)
    end

    test "update_auth_tokens/2 with valid data updates the auth_tokens" do
      auth_tokens = auth_tokens_fixture()
      assert {:ok, %AuthToken{} = auth_tokens} = Accounts.update_auth_tokens(auth_tokens, @update_attrs)
      assert auth_tokens.token == "some updated token"
    end

    test "update_auth_tokens/2 with invalid data returns error changeset" do
      auth_tokens = auth_tokens_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_auth_tokens(auth_tokens, @invalid_attrs)
      assert auth_tokens == Accounts.get_auth_tokens!(auth_tokens.id)
    end

    test "delete_auth_tokens/1 deletes the auth_tokens" do
      auth_tokens = auth_tokens_fixture()
      assert {:ok, %AuthToken{}} = Accounts.delete_auth_tokens(auth_tokens)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_auth_tokens!(auth_tokens.id) end
    end

    test "change_auth_tokens/1 returns a auth_tokens changeset" do
      auth_tokens = auth_tokens_fixture()
      assert %Ecto.Changeset{} = Accounts.change_auth_tokens(auth_tokens)
    end
  end
end
