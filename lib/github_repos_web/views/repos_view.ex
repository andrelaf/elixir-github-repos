defmodule GithubReposWeb.ReposView do
  use GithubReposWeb, :view

  alias GithubRepos.RepoInfo

  def render("repos.json", %{repos: [%RepoInfo{} | _tails] = repos}), do: %{repos: repos}
end
