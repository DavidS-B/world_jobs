defmodule WebhookProcessor.Application do
  @moduledoc "OTP Application specification for WebhookProcessor"

  use Application

  def start(_, _) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: WebhookProcessor.Endpoint,
        options: [port: 4000]
      )
    ]

    opts = [strategy: :one_for_one, name: WebhookProcessor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
