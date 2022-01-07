defmodule GithubReposWeb.ReposView do
  use GithubReposWeb, :view

  def render("404.json", %{message: message}) do
    %{message: message}
  end

  def render("show.json", %{body: body}) do
    Enum.map(body, fn repo ->
      project_name = Map.get(repo, "full_name")
      id = Map.get(repo, "id")
      description = Map.get(repo, "description")

      html_url = Map.get(repo, "html_url")

      stargazers_count = Map.get(repo, "stargazers_count")

      %{
        id: id,
        repo_name: project_name,
        description: description,
        html_url: html_url,
        stargazers_count: stargazers_count
      }
    end)
  end
end
