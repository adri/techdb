defmodule Techdb.Crawl.Sync do
  @moduledoc false
  alias Techdb.Crawl.Github, as: Github
  alias Techdb.Store.Graph, as: Graph

  def sync do
    crawl_users(["adri"])
      |> Enum.map(&(extract_users(&1)))
      |> IO.inspect
      |> Enum.map(&(crawl_users(&1)))
  end

  defp extract_users(user) do
    user
      |> get_in(["starredRepositories", "edges"])
      |> Enum.filter_map(&(&1["node"]["owner"]["login"] != nil), &(&1["node"]["owner"]["login"]))
      |> Enum.uniq
  end

  defp crawl_users(users) do
    users
    |> Enum.map(&(Github.user_profile(&1)))
    |> Enum.map(&(Graph.store_github_profile(&1["data"]["user"])))
  end
end
