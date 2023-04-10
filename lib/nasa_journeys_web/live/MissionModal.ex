defmodule NasaJourneysWeb.Live.MissionModal do
  use NasaJourneysWeb, :live_view

  @planet_gravity_mapping %{
    earth: 9.807,
    moon: 1.62,
    mars: 3.711
  }

  def mount(_params, session, socket) do
    defaults = %{
      mission: session["mission"],
      planets: planet_name_by_gravity()
    }

    {:ok, assign(socket, defaults)}
  end

  def handle_event("close", _params, socket) do
    send(socket.parent_pid, :close_mission_modal)
    {:noreply, socket}
  end

  def handle_event("remove_planet", %{"index" => index}, socket) do
    index = String.to_integer(index)
    mission = socket.assigns.mission
    mission_path = List.delete_at(mission["mission_path"], index)
    mission = %{mission | "mission_path" => mission_path}

    send(socket.parent_pid, {:remove_planet, index})
    {:noreply, assign(socket, mission: mission)}
  end

  def planet_name_by_gravity do
    Enum.map(@planet_gravity_mapping, fn {planet, gravity} ->
      {Kernel.inspect(gravity), planet}
    end)
    |> Map.new()
  end
end
