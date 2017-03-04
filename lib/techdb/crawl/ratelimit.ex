defmodule Techdb.Crawl.Ratelimit do
  @moduledoc false

  def limit_access(request, opts \\ []) do
    bucket = Keyword.get(opts, :bucket, "default")
    scale = Keyword.get(opts, :scale, 1_000)
    limit = Keyword.get(opts, :limit, 1)

    case ExRated.check_rate(bucket, scale, limit) do
      {:ok, _} ->
        request.()

      {:error, _} ->
        :timer.sleep(1_000)
        limit_access(request, opts)
    end
  end
end
