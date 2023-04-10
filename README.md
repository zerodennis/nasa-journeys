## NASA Journeys

<img width="1440" alt="Screenshot 2023-04-10 at 22 24 55" src="https://user-images.githubusercontent.com/19771211/230920925-f7f74aef-cd44-4f63-b2cd-75bc8633b446.png">

<img width="1440" alt="Screenshot 2023-04-10 at 22 25 25" src="https://user-images.githubusercontent.com/19771211/230920957-1afc2e66-df7a-4bdf-b944-dc3eb923cc22.png">

A project used to calculate the total amount of fuel needed in order to complete a space mission **(not real)**

## Installation

- Install elixir
- Install phoenix
- Get all dependencies: `mix deps.get` on project root

## Just Running the Calculation

- In project root: `iex -S mix`
- `NasaJourneys.Services.JourneyCalculationService.calculate_total_fuel(x, y)`
  - Replace `x` and `y` with the appropriate arguments

## Running the frontend

- In project root: `iex -S mix phx.server`
- Go to `localhost:4000/nasa` in your browser

## Running tests

- `mix test` on project root
- Run the test for the specific file for the calculation:
  - `mix test test/nasa_journeys/services/journey_calculation_service_test.exs`
