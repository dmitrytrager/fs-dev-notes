defmodule FsDev.Router do
  use FsDev.Web, :router

  pipeline :browser do
    plug BasicAuth, use_config: :basic_auth
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FsDev do
    pipe_through :browser # Use the default browser stack

    resources "notes", NoteController, only: [:create, :show]
    resources "tags", TagController, only: [:index, :show] do
      resources "notes", NoteController, only: [:index]
    end
    get "/", TagController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", FsDev do
  #   pipe_through :api
  # end
end
