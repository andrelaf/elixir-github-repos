defmodule GithubRepos.Users.Create do
  alias GithubRepos.{Error, User, Repo}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result
  defp handle_insert({:error, reason}), do: {:error, Error.build(:bad_request, reason)}
end
