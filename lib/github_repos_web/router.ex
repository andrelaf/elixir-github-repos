defmodule GithubReposWeb.Router do
  use GithubReposWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GithubReposWeb do
    pipe_through :api
  end

  pipeline :auth do
    plug GithubReposWeb.Auth.Pipeline
  end

  scope "/api", GithubReposWeb do
    pipe_through :api

    resources "/users", UsersController, only: [:create]
    post "/users/sign_in", UsersController, :sign_in
  end

  scope "/api", GithubReposWeb do
    pipe_through [:api, :auth]

    get "/repos/:username", ReposController, :show
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: GithubReposWeb.Telemetry
    end
  end
end
