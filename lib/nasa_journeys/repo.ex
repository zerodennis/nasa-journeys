defmodule NasaJourneys.Repo do
  use Ecto.Repo,
    otp_app: :nasa_journeys,
    adapter: Ecto.Adapters.Postgres
end
