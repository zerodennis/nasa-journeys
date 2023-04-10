defmodule NasaJourneysWeb.MissionCalculatorLive do
  use NasaJourneysWeb, :live_view
  alias NasaJourneys.Services.JourneyCalculationService

  @planet_gravity_mapping %{
    earth: 9.807,
    moon: 1.62,
    mars: 3.711
  }

  @default_mission_config %{
    "ship_mass" => nil,
    "mission_path" => []
  }

  def mount(_params, _session, socket) do
    defaults = %{
      mission: @default_mission_config,
      selected_planet: nil,
      total_fuel: nil,
      planets: planet_mapping_to_string_list(),
      show_modal: false
    }

    {:ok, assign(socket, defaults)}
  end

  def handle_event("select_planet", %{"planet" => planet}, socket) do
    {:noreply, assign(socket, selected_planet: planet)}
  end

  def handle_event(
        "add_launch",
        _params,
        %{
          assigns: %{
            selected_planet: planet,
            mission: %{"mission_path" => mission_path} = mission
          }
        } = socket
      ) do
    gravity = @planet_gravity_mapping[String.to_existing_atom(planet)]
    mission = %{mission | "mission_path" => mission_path ++ [{:launch, gravity}]}

    {:noreply, assign(socket, mission: mission)}
  end

  def handle_event(
        "add_landing",
        _params,
        %{
          assigns: %{
            selected_planet: planet,
            mission: %{"mission_path" => mission_path} = mission
          }
        } = socket
      ) do
    gravity = @planet_gravity_mapping[String.to_existing_atom(planet)]
    mission = %{mission | "mission_path" => mission_path ++ [{:land, gravity}]}

    {:noreply, assign(socket, mission: mission)}
  end

  def handle_event("change_ship_mass", %{"ship_mass" => ship_mass}, socket) do
    mission = socket.assigns.mission
    mission = %{mission | "ship_mass" => ship_mass}
    {:noreply, assign(socket, mission: mission)}
  end

  def handle_event(
        "submit",
        _params,
        %{assigns: %{mission: %{"mission_path" => mission_path} = mission}} = socket
      ) do
    ship_mass = String.to_integer(mission["ship_mass"])
    total_fuel = JourneyCalculationService.calculate_total_fuel(ship_mass, mission_path)

    {:noreply,
     assign(socket, total_fuel: total_fuel, selected_planet: nil, mission: @default_mission_config)}
  end

  def handle_event(
        "open-view-mission-modal",
        _params,
        socket
      ) do
    {:noreply, assign(socket, show_modal: true)}
  end

  def handle_info(:close_mission_modal, socket), do: {:noreply, assign(socket, show_modal: false)}

  def handle_info({:remove_planet, index}, %{assigns: assigns} = socket) do
    mission = assigns[:mission]
    mission_path = List.delete_at(mission["mission_path"], index)
    mission = %{mission | "mission_path" => mission_path}

    {:noreply, assign(socket, mission: mission)}
  end

  def classes(classes) do
    classes
    |> Enum.filter(&elem(&1, 1))
    |> Enum.map(&elem(&1, 0))
    |> Enum.join(" ")
  end

  def is_submit_disabled?(mission) do
    Map.equal?(mission, @default_mission_config) or mission["ship_mass"] in ["", nil] or
      mission["mission_path"] == []
  end

  def is_modal_disabled?(mission), do: mission["mission_path"] in [nil, []]

  defp planet_mapping_to_string_list do
    Enum.map(@planet_gravity_mapping, fn {k, _v} ->
      Atom.to_string(k)
    end)
  end
end
