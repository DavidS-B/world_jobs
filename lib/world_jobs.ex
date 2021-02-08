defmodule WorldJobs do
  @moduledoc "Main module of the `world_jobs` application."

  alias WorldJobs.Renderer
  alias WorldJobs.CSVParser, as: CSV

  defstruct [
    :Admin,
    :Business,
    :Créa,
    :"Marketing / Comm'",
    :Retail,
    :Tech,
    :Conseil,
    :"Unknown profession",
    :Total
  ]

  @doc "Generate a text-based table for display from a map."
  @spec render_table() :: String.t() | no_return
  def render_table do
    collect()
    |> Renderer.format()
  end

  @doc "Generate a map from two CSV files."
  @spec collect() :: map
  def collect do
    jobs_map = Map.from_struct(__MODULE__)
    professions = CSV.get_professions()

    CSV.get_jobs()
    |> Enum.reduce(%{}, fn {continent, id}, map ->
      profession = professions[id] || :"Unknown profession"

      updated_map = %{
        continent => %{
          jobs_map
          | profession => (map[continent][profession] || 0) + 1,
            :Total => (map[continent][:Total] || 0) + 1
        },
        :Total => %{
          jobs_map
          | profession => (map[:Total][profession] || 0) + 1,
            :Total => (map[:Total][:Total] || 0) + 1
        }
      }

      Map.merge(map, updated_map, fn _, value_1, value_2 ->
        %{value_1 | profession => value_2[profession], :Total => value_2[:Total]}
      end)
    end)
  end
end
