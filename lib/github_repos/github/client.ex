defmodule GithubRepos.Github.Client do
  use Tesla

  alias Tesla.Env, as: Response
  alias GithubRepos.{RepoInfo, Error}

  alias GithubRepos.Github.Behaviour

  @behaviour Behaviour

  @base_url "https://api.github.com"
  @request_headers [
    {"User-Agent", "github_repos"}
  ]

  plug Tesla.Middleware.Headers, @request_headers
  plug Tesla.Middleware.JSON

  def get_user_repos(url \\ @base_url, username) do
    "#{url}/users/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Response{status: 200, body: raw_repos}}),
    do: {:ok, RepoInfo.build_many(raw_repos)}

  defp handle_get({:ok, %Response{status: 404, body: _body}}),
    do: {:error, Error.build(:not_found, "Github user not found")}

  defp handle_get({:error, reason}), do: {:error, Error.build(:bad_request, reason)}
end
