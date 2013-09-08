defmodule Rdg.QuotesTest do
  use Rdg.TestCase

  test "will be true" do
    xml = "
      <root>
        <child>a</child>
        <child>b</child>
      </root>
    "
    #TODO: mock request
    content = Quotes.parsed_content
    assert content != ''
  end
end
