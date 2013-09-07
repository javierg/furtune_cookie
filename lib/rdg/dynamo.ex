defmodule Rdg.Dynamo do
  use Dynamo

  config :dynamo,
    # The environment this Dynamo runs on
    env: Mix.env,

    # The OTP application associated with this Dynamo
    otp_app: :rdg,

    # The endpoint to dispatch requests to
    endpoint: ApplicationRouter,

    # The route from which static assets are served
    # You can turn off static assets by setting it to false
    static_route: "/static"

  # Uncomment the lines below to enable the cookie session store
  # config :dynamo,
  #   session_store: Session.CookieStore,
  #   session_options:
  #     [ key: "_rdg_session",
  #       secret: "5x2s3TjXgJaZ8b/vEUIhLnAPYNJyU4N13kziQv8z3jkzibGgtvXfVlrNTe1o6w/A"]

  # Default functionality available in templates
  templates do
    use Dynamo.Helpers
  end
end
