defmodule Techdb.Crawl.Sync do
  @moduledoc false
  alias Techdb.Crawl.Github, as: Github
  alias Techdb.Store.Graph, as: Graph

  def sync do
    crawl_users(["lapistano"])
      |> Enum.map(&(extract_users(&1)))
      |> IO.inspect
      |> Enum.map(&(crawl_users(&1)))
  end

  defp extract_users(user) do
    user
      |> get_in(["starredRepositories", "edges"])
      |> Enum.filter_map(&(owner_login(&1) != nil), &(owner_login(&1)))
      |> Enum.uniq
  end

  defp owner_login(repo) do
    repo["node"]["owner"]["login"]
  end

  defp crawl_users(users) do
    users
    |> Enum.map(&(Github.user_profile(&1)))
    |> Enum.map(&(Graph.store_github_profile(&1["data"]["user"])))
  end
end
