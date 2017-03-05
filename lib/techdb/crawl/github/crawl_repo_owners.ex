defmodule Techdb.Crawl.Github.CrawlRepoOwners do
  @moduledoc false
  alias Techdb.Crawl.Github, as: Github
  alias Techdb.Store.Graph, as: Graph

  def crawl do
    ["lapistano"]  # replace this with "get users to crawl"
      |> Stream.map(&crawl_login(&1))
      |> Stream.map(&starred_repo_owners(&1))
      |> Stream.flat_map(fn(x) -> x end)
      |> Stream.map(&crawl_login(&1))
      |> Enum.to_list
  end

  defp crawl_login(login)  do
    login
      |> Github.user_profile
      |> store_user
  end

  defp starred_repo_owners(user) do
    user
      |> get_in(["data", "user", "starredRepositories", "edges"])
      |> Stream.filter_map(&(owner_login(&1) != nil), &(owner_login(&1)))
      |> Stream.uniq
  end

  defp owner_login(repo) do
    repo["node"]["owner"]["login"]
  end

  defp store_user(user) do
    Graph.store_github_profile(user["data"]["user"])
    user
  end
end
