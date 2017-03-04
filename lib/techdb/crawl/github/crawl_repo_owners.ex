defmodule Techdb.Crawl.Github.CrawlRepoOwners do
  @moduledoc false
  alias Techdb.Crawl.Github, as: Github
  alias Techdb.Store.Graph, as: Graph

  def crawl do
    ["SlexAxton"]  # replace this with "get users to crawl"
      |> Stream.map(&(Github.user_profile(&1)))
      |> Stream.map(&(store_user(&1)))
      |> Stream.map(&(starred_repo_owners(&1)))
      |> Enum.to_list
  end

  defp starred_repo_owners(user) do
    user
      |> get_in(["starredRepositories", "edges"])
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
