defmodule GithubRepos.Github.Behaviour do
  alias GithubRepos.Error

  @typep get_user_repos_return :: {:ok, list()} | {:error, Error.t()}
  @callback get_user_repos(String.t()) :: get_user_repos_return
end
