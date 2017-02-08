defmodule Techdb.Crawl.Twitter do
  @moduledoc false

  alias Techdb.Store.Graph, as: Graph

  def from_github_logins() do
    Graph.logins_for_twitter
#    |> IO.inspect
      |> Enum.map(&(user_profile(&1)))
      |> Enum.filter(&(&1 != nil))
      |> Enum.map(&(Graph.store_twitter_profile(&1)))
      |> Enum.map(&(Graph.github_user_crawled_twitter(&1.screen_name)))
  end

  def user_profile(login) do
    try do
      ExTwitter.user(login)
      |> Map.from_struct
    rescue
       ExTwitter.Error -> nil
    end
  end
end
