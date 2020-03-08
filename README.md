# Languager


__Requirements__
- [Elixir](http://elixir-lang.org/)/[Mix](http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html)/[Phoenix](http://www.phoenixframework.org/) ([Installation guide](http://www.phoenixframework.org/docs/installation))
- [Node.js](https://nodejs.org/en/)/[npm](https://www.npmjs.com/) (Install using [nvm](https://github.com/creationix/nvm))
- Database

__Initial Setup__
  npm install (Gets npm dependencies)
  mix deps.get (Gets Phoenix dependencies)
  mix ecto.create (Sets up database)
  mix ecto.migrate (Runs migrations)
  mix phx.server (start server)
  - Go to localhost:4000 (or whatever port is specified in dev.exs)

__Updating__
  mix deps.get
  mix deps.compile
  mix ecto.migrate
  mix phx.server



__Testing__
  MIX_ENV=test mix ecto.create
  MIX_ENV=test mix ecto.migrate
  MIX_ENV=test mix ecto.reset
  mix test





mix phx.new languager
npm install postcss-loader tailwindcss --save-dev


mix phx.gen.context Accounts User users email:string:unique encrypted_password:string external_id:string:unique
mix phx.gen.context Languages Language languages external_id:string:unique name:string
mix phx.gen.context Puzzles WordSearch word_searches external_id:string:unique name:string
mix phx.gen.html Languages Course courses language_id:integer user_id:integer name:string description:string 
mix phx.gen.html Languages Word words language_id:integer course_id:integer user_id:integer translation:string literal_translation:string pronunciation:string sound_clip:string 
mix phx.gen.html Languages Sentence sentences language_id:integer course_id:integer word_id:integer user_id:integer translation:string literal_translation:string sound_clip:string 
