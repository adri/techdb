defmodule Techdb.Crawl.Twitter do
  @moduledoc false
  @ratelimit [
    scale: 1_000,
    limit: 1,
    bucket: :twitter
  ]

  alias Techdb.Crawl.Ratelimit, as: Ratelimit

  def user_profile(login) do
    try do
      Ratelimit.limit_access(fn ->
        ExTwitter.user(login)
        |> Map.from_struct
      end, @ratelimit)
    rescue
       ExTwitter.Error -> nil
    end
  end
end
