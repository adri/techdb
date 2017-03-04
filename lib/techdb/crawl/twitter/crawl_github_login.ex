defmodule Techdb.Crawl.Twitter.CrawlGithubLogin do
  @moduledoc false
  alias Techdb.Crawl.Twitter, as: Twitter
  alias Techdb.Store.Graph, as: Graph

  defmodule PotentialTwitterProfile do
    defstruct github_login: nil, twitter_profile: nil

    def from_github(login) do
       %PotentialTwitterProfile{github_login: login}
    end

    def has_profile?(%PotentialTwitterProfile{twitter_profile: nil}), do: false
    def has_profile?(%PotentialTwitterProfile{twitter_profile: _}), do: true
  end

  def crawl() do
    Graph.logins_for_twitter
      |> Stream.map(&(PotentialTwitterProfile.from_github(&1)))
      |> Stream.map(&find_twitter_profile(&1))
      |> Stream.filter(&(PotentialTwitterProfile.has_profile?(&1)))
      |> Stream.map(&(store_twitter(&1)))
      |> Stream.map(&(store_github_crawled_twitter(&1)))
      |> Enum.to_list
  end

  defp find_twitter_profile(profile) do
    %{profile | twitter_profile: Twitter.user_profile(profile.github_login) }
  end

  defp store_twitter(profile) do
    Graph.store_twitter_profile(profile.twitter_profile)
    profile
  end

  defp store_github_crawled_twitter(profile) do
    Graph.github_user_crawled_twitter(profile.github_login)
    profile
  end
end
