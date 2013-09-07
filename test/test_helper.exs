Dynamo.under_test(Rdg.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule Rdg.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
