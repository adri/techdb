defmodule Techdb.Crawl.Github do
  @moduledoc false
  use HTTPotion.Base

  alias Techdb.Query.Query, as: Query

  @spec user_profile(String.t) :: Map
  def user_profile(login) do
    Query.read_query("GithubProfile.graphql")
      |> query(%{:login => login})
  end

#  ----

  defp process_url(url) do
    "https://api.github.com/graphql" <> url
  end

  defp process_request_headers(headers) do
    headers
      |> Dict.put(:"User-Agent", "github-potion")
      |> Dict.put(:"Authorization", "Bearer " <> Application.get_env(:techdb, :github_token))
  end

   def process_response_body(body) do
      body |> Poison.decode!
    end

  defp query(query, variables) do
    post("", [
      body: Poison.encode! %{
        :query => query,
        :variables => variables
      }
    ]).body
  end
end
