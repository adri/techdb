defmodule Techdb.Web.PageController do
  use Techdb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
