defmodule Techdb.Store.GithubProfile do
  @moduledoc false

  import Techdb.Query.Query, only: [read_query: 1]

  def contributors() do
    read_query("FindGithubContributors.cypher")
      |> query
  end

#  ----

  defp query(query, parameters \\ %{}) do
    Bolt.Sips.query!(Bolt.Sips.conn, query, parameters)
  end

end
