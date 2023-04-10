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

    Enum.reduce(mission_path, mass, fn
      {:launch, gravity}, acc ->
        calculate_launch_fuel(acc, gravity, 0) + acc

      {:land, gravity}, acc ->
        calculate_landing_fuel(acc, gravity, 0) + acc
    end) - mass
  end

  @doc """
  Recursively calculates the additional fuel needed for a launch until
  the additional needed left is 0 or negative

  ## Examples

    iex> calculate_launch_fuel(28801, 9.807, 28801)
  """
  def calculate_launch_fuel(mass, gravity, acc) when mass > 0 do
    fuel =
      mass
      |> apply_formula(gravity, @launch_lhs_constant, @launch_rhs_constant)
      |> floor()

    calculate_launch_fuel(fuel, gravity, fuel + acc)
  end

  def calculate_launch_fuel(mass, _gravity, acc), do: acc + abs(mass)

  @spec calculate_landing_fuel(number, any, number) :: number
  @doc """
  Recursively calculates the additional fuel needed for a launchuntil
  the additional needed left is 0 or negative

  ## Examples

    iex> calculate_landing_fuel(28801, 9.807, 28801)
  """

  def calculate_landing_fuel(mass, gravity, acc) when mass > 0 do
    fuel =
      mass
      |> apply_formula(gravity, @landing_lhs_constant, @landing_rhs_constant)
      |> floor()

    calculate_landing_fuel(fuel, gravity, fuel + acc)
  end

  def calculate_landing_fuel(mass, _gravity, acc), do: acc + abs(mass)

  defp apply_formula(mass, gravity, constant_1, constant_2),
    do: mass * gravity * constant_1 - constant_2
end
