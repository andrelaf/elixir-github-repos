ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubRepos.Repo, :manual)
Mox.defmock(GithubRepos.Github.ClientMock, for: GithubRepos.Github.Behaviour)
