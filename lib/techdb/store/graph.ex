defmodule Techdb.Store.Graph do
  @moduledoc false

  import Techdb.Query.Query, only: [read_query: 1]

  def store_github_profile(user) do
    read_query("UpdateGithubProfile.cypher")
      |> query(%{"user" => user})

    user
  end

  defp query(query, parameters) do
    Bolt.Sips.query!(Bolt.Sips.conn, query, parameters)
  end

end
