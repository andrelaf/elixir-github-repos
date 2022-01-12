defmodule GithubRepos do
  alias GithubRepos.Users.Create, as: CreateUser

  defdelegate create_user(params), to: CreateUser, as: :call
end
