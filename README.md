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




mix phx.new carpedia --database mysql

npm install postcss-loader tailwindcss --save-dev



mix phx.gen.context Accounts User users email:string:unique encrypted_password:string external_id:string:unique
mix phx.gen.html Cars Car cars name:string make:string model:string year:string
