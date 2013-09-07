defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
defrecord XMLElement, element: nil

defmodule Quotes do
  def retrieve, do: messages |> Enum.first

  defp messages do
    rss_msg_node_index = 8
    Enum.map parsed_content |> titles, fn(msg_node) ->
      {_, _, _, _, msg, _} = Enum.first( elem msg_node, rss_msg_node_index )
      msg
    end
  end

  defmacrop empty_node, do: [element: nil]

  defp xml_doc do
    #TODO: Cache responses
    HTTPotion.start
    HTTPotion.get("http://wertarbyte.de/gigaset-rss/?long=1&limit=140&cookies=20&lang=en&lang=es&format=rss&jar=off%2Flinux%2Coff%2Fmiscellaneous%2Coff%2Freligion%2Coff%2Friddles%2Coff%2Fsongs-poems%2Cparadoxum%2Cpeople%2Cpets%2Cpolitics%2Criddles%2Cscience%2Csongs-poems%2Cstartrek%2Cwisdom").body
  end

  defp from_element(element) do
    XMLElement.new(element: element)
  end

  defp xpath(empty_node(), _), do: []

  defp xpath(node, path) do
    :xmerl_xpath.string(to_char_list(path), node.element)
  end

  def titles(node) do
    title_node_path = "//item/title"
    node |> xpath(title_node_path)
  end

  defp parsed_content do
    {_, str} = String.to_char_list(xml_doc)
    {doc, []} = str |> :xmerl_scan.string([comments: false])
    from_element(doc)
  end
end
