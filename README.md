## NASA Journeys
<img width="1440" alt="Screenshot 2023-04-09 at 01 39 34" src="https://user-images.githubusercontent.com/19771211/230735918-ca877236-cdd8-40f3-9dfc-78f1b22aab8d.png">

https://user-images.githubusercontent.com/19771211/230736239-b0b4f423-87a3-4331-b946-41d8d92a35ca.mov

A project used to calculate the total amount of fuel needed in order to complete a space mission **(not real)**

## Installation

- Install elixir
- Install phoenix
- Get all dependencies `mix deps.get` on project root

## Just Running the Calculation

- In project root: `iex -S mix`
- `NasaJourneys.Services.JourneyCalculationService.calculate_total_fuel(x, y)`
- Replace `x` and `y` with the appropriate arguments

## Running the frontend

- In project root: `iex -S mix phx.server`
- Go to `localhost:4000/nasa` in your browser
