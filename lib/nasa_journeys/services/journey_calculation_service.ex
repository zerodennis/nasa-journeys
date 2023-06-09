defmodule NasaJourneys.Services.JourneyCalculationService do
  @moduledoc """
  Functions for calculating the total amount of fuel needed to
  complete a full space mission
  """

  @launch_lhs_constant 0.042
  @launch_rhs_constant 33
  @landing_lhs_constant 0.033
  @landing_rhs_constant 42

  @doc """
  Calculates the total amount of fuel needed for a complete mission,
  rounded down

  ## Examples

    iex> calculate_fuel(28801, [{:launch, 9.807}, {:land, 1.62}])
  """

  def calculate_total_fuel(mass, mission_path) do
    mission_path = Enum.reverse(mission_path)

    Enum.reduce(mission_path, mass, fn {action, gravity} = _v, acc ->
      calculate_additional_fuel(action, acc, gravity, 0) + acc
    end) - mass
  end

  # @doc """
  # Recursively calculates the additional fuel needed for a flight until
  # the additional needed left is 0 or negative

  # ## Examples

  #   iex> calculate_additional_fuel(:launch 28801, 9.807, 28801)
  # """

  def calculate_additional_fuel(:launch, mass, gravity, acc) when mass > 0 do
    fuel =
      :launch
      |> apply_formula(mass, gravity)
      |> floor()

    calculate_additional_fuel(:launch, fuel, gravity, fuel + acc)
  end

  def calculate_additional_fuel(:land, mass, gravity, acc) when mass > 0 do
    fuel =
      :land
      |> apply_formula(mass, gravity)
      |> floor()

    calculate_additional_fuel(:land, fuel, gravity, fuel + acc)
  end

  def calculate_additional_fuel(_action, mass, _gravity, acc), do: acc + abs(mass)

  defp apply_formula(:launch, mass, gravity),
    do: mass * gravity * @launch_lhs_constant - @launch_rhs_constant

  defp apply_formula(:land, mass, gravity),
    do: mass * gravity * @landing_lhs_constant - @landing_rhs_constant
end
