defmodule Techdb.Store.Graph do
  @moduledoc false

  import Techdb.Query.Query, only: [read_query: 1]

  def store_github_profile(user) do
    read_query("UpdateGithubProfile.cypher")
      |> query(%{"user" => user})

    user
  end

  def store_twitter_profile(user) do
    read_query("UpdateTwitterProfile.cypher")
      |> query(%{"user" => user})

    user
  end

  def github_user_crawled_twitter(login) do
    read_query("UpdateGithubUserCrawledTwitter.cypher")
      |> query(%{"login" => login})

    login
  end

  def logins_for_twitter() do
    read_query("FindGithubLoginsForTwitter.cypher")
      |> query
      |> Enum.map(&(&1["github.login"]))
      |> Enum.filter(&(&1 != nil))
  end

  def find_repo_owners() do
    read_query("FindRepoOwners.cypher")
      |> query
      |> Enum.map(&(&1["github.login"]))
      |> Enum.filter(&(&1 != nil))
  end

#  ----

  defp query(query, parameters \\ %{}) do
    Bolt.Sips.query!(Bolt.Sips.conn, query, parameters)
  end

end
