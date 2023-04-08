defmodule NasaJourneys.Services.JourneyCalculationServiceTest do
  use NasaJourneysWeb.ConnCase
  alias NasaJourneys.Services.JourneyCalculationService, as: Calculation

  describe "calculate_total_fuel/2" do
    test "passes 1st given test case" do
      apollo_11_total_fuel =
        Calculation.calculate_total_fuel(28801, [
          {:launch, 9.807},
          {:land, 1.62},
          {:launch, 1.62},
          {:land, 9.807}
        ])

      assert apollo_11_total_fuel == 51898
    end

    test "passes 2nd given test case" do
      mars_mission_total_fuel =
        Calculation.calculate_total_fuel(14606, [
          {:launch, 9.807},
          {:land, 3.711},
          {:launch, 3.711},
          {:land, 9.807}
        ])

      assert mars_mission_total_fuel == 33388
    end

    test "passes 3rd given test case" do
      passenger_ship_total_fuel =
        Calculation.calculate_total_fuel(75432, [
          {:launch, 9.807},
          {:land, 1.62},
          {:launch, 1.62},
          {:land, 3.711},
          {:launch, 3.711},
          {:land, 9.807}
        ])

      assert passenger_ship_total_fuel == 212_161
    end
  end
end
