defmodule GithubReposWeb.ReposController do
  use GithubReposWeb, :controller

  alias GithubRepos.Repos.Client

  # def show(conn, %{"username" => username}) do
  #   with {:ok, body} <- Client.user_repos(username) do
  #     conn
  #     |> put_status(:ok)
  #     |> render("show.json", body: body)
  #   end
  # end

  def show(conn, %{"username" => username}) do
    username
    |> Client.user_repos()
    |> handle_show(conn)
  end

  defp handle_show({:ok, body}, conn) do
    conn
    |> put_status(:ok)
    |> render("show.json", body: body)
  end

  defp handle_show({:error, %{"message" => "Not Found"}}, conn) do
    conn
    |> put_status(:not_found)
    |> render("404.json", message: "User not found")
  end
end
