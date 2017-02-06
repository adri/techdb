defmodule Techdb.Crawl.Github do
  @moduledoc false
  use HTTPotion.Base

  def process_url(url) do
    "https://api.github.com/graphql" <> url
  end

  def process_request_headers(headers) do
    headers
      |> Dict.put(:"User-Agent", "github-potion")
      |> Dict.put(:"Authorization", "Bearer 3acd62921a5a63b2ceb7947694846b7cc53ab447")
  end

  def query(query, variables) do
    post("", [
      body: Poison.encode! %{
        :query => File.read!(Path.expand("lib/techdb/crawl/" <> query)),
        :variables => variables
      }
    ])
  end

  def user_profile(login) do
    query("github/GithubProfile.graphql", %{ :login => login })
  end
end
