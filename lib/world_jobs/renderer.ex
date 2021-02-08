defmodule WorldJobs.Renderer do
  @moduledoc "Text-based table module renderer for the 'world_jobs' application."

  alias TableRex.Table

  @doc """
    Generate a text-based table for display from a map.
  """
  @spec format(map()) :: String.t() | no_return
  def format(map) do
    header = [
      "",
      "Total",
      "Admin",
      "Business",
      "Conseil",
      "Créa",
      "Marketing / Comm'",
      "Retail",
      "Tech",
      "Unknown profession"
    ]

    Enum.map(map, fn {elem, map} ->
      [
        elem,
        map[:Total],
        map[:Admin],
        map[:Business],
        map[:Conseil],
        map[:Créa],
        map[:"Marketing / Comm'"],
        map[:Retail],
        map[:Tech],
        map[:"Unknown profession"]
      ]
    end)
    |> Enum.sort_by(fn list -> List.first(list) != :Total end)
    |> Table.new(header)
    |> Table.put_column_meta(:all, align: :center)
    |> Table.render!(header_separator_symbol: "=", horizontal_style: :all)
    |> IO.puts()
  end
end
