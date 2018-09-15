defmodule RequestpoolWeb.Router do
  use RequestpoolWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RequestpoolWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
   scope "/api", RequestpoolWeb do
     pipe_through :api

     resources "/smartplugs", SmartPlugController, except: [:new, :edit]
   end
end
