# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#

IO.puts "Creating languages"
case Languager.Languages.get_language_by_external_id("spanish") do
  nil -> Languager.Languages.create_language(%{name: "Spanish", active: true})
  _ -> :ok
end
case Languager.Languages.get_language_by_external_id("french") do
  nil -> Languager.Languages.create_language(%{name: "French", active: true})
  _ -> :ok
end
case Languager.Languages.get_language_by_external_id("german") do
  nil -> Languager.Languages.create_language(%{name: "Germanpanish", active: true})
  _ -> :ok
end


IO.puts "Creating default user"
case Languager.Accounts.get_user_by_email("test@example.com") do
  nil -> Languager.Accounts.create_user(%{email: "test@example.com", password: "123123"})
  _ -> :ok
end