defmodule NasaJourneysWeb.PageController do
  use NasaJourneysWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
