defmodule WorldJobs.CSVParser do
  import String, only: [to_float: 1, to_atom: 1]
  alias NimbleCSV.RFC4180, as: CSV
  alias WorldJobs.Geolocation, as: Geolocation

  @jobs_csv "./data/technical-test-jobs.csv"
  @professions_csv "./data/technical-test-professions.csv"

  def parse(csv_file) do
    File.stream!(csv_file)
    |> CSV.parse_stream()
  end

  def get_jobs do
    parse(@jobs_csv)
    |> Stream.map(fn
      [id, _, _, latitude, longitude] when latitude != "" and longitude != "" ->
        continent = Geolocation.get_continent({to_float(latitude), to_float(longitude)})
        {continent, id}

      [id, _, _, _, _] ->
        {:"Unknown continent", id}
    end)
  end

  def get_professions do
    parse(@professions_csv)
    |> Enum.into(%{}, fn [id, _, categorie_name] -> {id, to_atom(categorie_name)} end)
  end
end
