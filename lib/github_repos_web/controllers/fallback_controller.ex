defmodule GithubReposWeb.FallbackController do
  use GithubReposWeb, :controller

  alias GithubRepos.Error
  alias GithubReposWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
