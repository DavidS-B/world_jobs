defmodule WebhookProcessor.Endpoint do
  @moduledoc """
    A Plug responsible for logging request info, parsing request body's as JSON,
    matching routes, and dispatching responses.
  """

  use Plug.Router
  import String, only: [to_atom: 1]

  @api_doc """
    Professions lookup with continent (JSON)

    Webservice Type: REST /JSON
    Url: http://localhost:4000/lookup
    Parameters: continent, profession
    Result: returns a list of professions by continent
    Example:
    http://localhost:4000/lookup/continent=Africa
    or
    http://localhost:4000/lookup/continent=Africa&profession=Tech
  """
  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, @api_doc)
  end

  get "/lookup/" do
    map = WorldJobs.collect()
    send_resp(conn, 200, Poison.encode!(map))
  end

  get "/lookup/:query" do
    map = WorldJobs.collect()

    query_map =
      case URI.decode_query(query) do
        %{"continent" => continent, "profession" => profession} ->
          %{
            to_atom(continent) => %{
              to_atom(profession) => map[to_atom(continent)][to_atom(profession)]
            }
          }

        %{"continent" => continent} ->
          map[to_atom(continent)]

        _ ->
          "bad request"
      end

    send_resp(conn, 200, Poison.encode!(query_map))
  end

  match _ do
    send_resp(conn, 404, "bad request")
  end
end
