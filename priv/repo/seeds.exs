# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#

IO.puts "Creating languages"
Languager.Repo.delete_all(Languager.Languages.Language)
Languager.Languages.create_language(%{name: "Spanish", active: true})
Languager.Languages.create_language(%{name: "French", active: true})
Languager.Languages.create_language(%{name: "German", active: true})
