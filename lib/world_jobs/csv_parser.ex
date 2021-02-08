defmodule WorldJobs.CSVParser do
  @moduledoc "CSV parser module for the 'world_jobs' application."

  import String, only: [to_float: 1, to_atom: 1]
  alias NimbleCSV.RFC4180, as: CSV
  alias WorldJobs.Geolocation, as: Geolocation

  @jobs_csv "data/technical-test-jobs.csv"
  @professions_csv "data/technical-test-professions.csv"

  @doc "Steam parse a CSV file using the 'nimble_csv' library."
  @spec parse(Path.t()) :: Enumerable.t()
  def parse(csv_file) do
    File.stream!(csv_file)
    |> CSV.parse_stream()
  end

  @doc """
    Parse the "data/technical-test-professions.csv" file and
    insert the result into a map.
  """
  @spec get_professions :: %{String.t() => atom}
  def get_professions do
    parse(@professions_csv)
    |> Enum.into(%{}, fn [id, _, categorie_name] -> {id, to_atom(categorie_name)} end)
  end

  @doc """
    Parse the "data/technical-test-jobs.csv" file and
    creates a stream that will return a tuple list with
    a continent atom as first element and
    a job id as second element for each tuple.
  """
  @spec get_jobs() :: Enumerable.t()
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
end
