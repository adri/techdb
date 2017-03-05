defmodule Techdb.Web.PageController do
  use Techdb.Web, :controller

  def index(conn, _params) do
    Techdb.Store.GithubProfile
    render conn, "index.html",
      contributors: Techdb.Store.GithubProfile.contributors
  end
end
