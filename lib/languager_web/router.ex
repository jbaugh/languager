defmodule LanguagerWeb.Router do
  use LanguagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug LanguagerWeb.Plugs.LoadCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LanguagerWeb do
    pipe_through :api

    resources "/languages", LanguageController, except: [:new, :edit]
  end

  scope "/", LanguagerWeb do
    pipe_through :browser

    # get "/logout", SessionController, :delete
    # get "/signout", SessionController, :delete
    # get "/login", SessionController, :new
    # get "/signin", SessionController, :new
    # resources "/sessions", SessionController, only: [:new, :create, :delete]

    # get "/signup", SignupController, :new
    # post "/signup", SignupController, :create

    # get "/", PageController, :index
    get "/*path", PageController, :index
  end
end
