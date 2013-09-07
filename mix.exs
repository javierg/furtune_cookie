defmodule Rdg.Mixfile do
  use Mix.Project

  def project do
    [ app: :rdg,
      version: "0.0.1",
      dynamos: [Rdg.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/rdg/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo, :xmerl],
      mod: { Rdg, [] } ]
  end

  defp deps do
    [ { :cowboy, github: "extend/cowboy" },
      { :dynamo, "0.1.0-dev", github: "elixir-lang/dynamo" },
      { :httpotion, github: "myfreeweb/httpotion" }
     ]
  end
end
