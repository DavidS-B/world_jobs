defmodule WorldJobs.TableFormatter do
  alias TableRex.Table

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
