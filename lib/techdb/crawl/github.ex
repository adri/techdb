defmodule Techdb.Crawl.Github do
  @moduledoc false
  use HTTPotion.Base

  @endpoint "https://api.github.com/graphql"
  @ratelimit [
    scale: 1_000,
    limit: 1,
    bucket: @endpoint
  ]

  alias Techdb.Crawl.Ratelimit, as: Ratelimit
  import Techdb.Query.Query, only: [read_query: 1]

  @spec user_profile(String.t) :: Map
  def user_profile(login) do
    read_query("GithubProfile.graphql")
      |> ratelimit_query(%{:login => login})
  end

#  ----

  defp process_url(url) do
    @endpoint <> url
  end

  defp process_request_headers(headers) do
    headers
      |> Dict.put(:"User-Agent", "github-potion")
      |> Dict.put(:"Authorization", "Bearer " <> Application.get_env(:techdb, :github_token))
  end

  defp process_response_body(body) do
    Poison.decode!(body)
  end

  defp ratelimit_query(query, variables \\ %{}) do
    Ratelimit.limit_access(fn -> query(query, variables) end, @ratelimit)
  end

  defp query(query, variables \\ %{}) do
    post("", [
      body: Poison.encode!(%{
        :query => query,
        :variables => variables
      })
    ]).body
  end
end
