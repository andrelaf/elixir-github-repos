# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :github_repos, ecto_repos: [GithubRepos.Repo]

# Configures the endpoint
config :github_repos, GithubReposWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XYnglHZl8eAXikgINQr90PzuaDPKvRm+lvO8nvVNqu7QEmQu91uUgi6pnyq7LY7h",
  render_errors: [view: GithubReposWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GithubRepos.PubSub,
  live_view: [signing_salt: "TYFM8tyk"]

# Configures the bypass mox
config :github_repos, GithubReposWeb.ReposController, github_adapter: GithubRepos.Github.Client

# Configures the guardian
config :github_repos, GithubReposWeb.Auth.Guardian,
  issuer: "github_repos",
  secret_key: "8N/uPUUWbFku4F5dWG1gnx0TvjW/3K6KVqvMzYIJxg7INrzXg+GafK2biOl7nTin"

config :github_repos, GithubReposWeb.Auth.Pipeline,
  module: GithubReposWeb.Auth.Guardian,
  error_handler: GithubReposWeb.Auth.ErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
