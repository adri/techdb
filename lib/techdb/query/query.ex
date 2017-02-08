defmodule Techdb.Query.Query do
  @moduledoc false

  def read_query(file) do
    File.read!(Path.expand("lib/techdb/query/" <> file))
  end
end
