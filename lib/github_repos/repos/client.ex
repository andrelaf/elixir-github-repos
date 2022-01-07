defmodule GithubRepos.Repos.Client do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.github.com")
  plug(Tesla.Middleware.Headers, [{"User-Agent", "ignite_github"}])
  plug(Tesla.Middleware.JSON)

  alias Tesla.Env

  def user_repos(username) do
    "/users/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 404, body: %{"message" => "Not Found"}}}) do
    {:error, %{"message" => "Not Found"}}
  end

  # {:error, {:no_scheme}}
  defp handle_get({:error, reason}) do
    {:error, reason}
  end
end
