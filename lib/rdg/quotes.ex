defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
defrecord XMLElement, element: nil

defmodule Quotes do
  @url "http://wertarbyte.de/gigaset-rss/?long=1&limit=140&cookies=20&lang=en&lang=es&format=rss&jar=off%2Flinux%2Coff%2Fmiscellaneous%2Coff%2Freligion%2Coff%2Friddles%2Coff%2Fsongs-poems%2Cparadoxum%2Cpeople%2Cpets%2Cpolitics%2Criddles%2Cscience%2Csongs-poems%2Cstartrek%2Cwisdom"

  def retrieve, do: messages |> Enum.first

  defp messages do
    Enum.map parsed_content |> titles, &get_msg/1
  end

  defp get_msg node do
    rss_msg_node_index = 8
    {_, _, _, _, msg, _} = Enum.first( elem node, rss_msg_node_index )
    msg
  end

  defmacrop empty_node, do: [element: nil]

  defp request_doc do
    #TODO: Cache responses
    HTTPotion.start
    HTTPotion.get(@url)
  end

  defp xml_doc do
    {_, bite_str} = String.to_char_list( request_doc.body )
    bite_str
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
    {doc, []} = xml_doc |> :xmerl_scan.string([comments: false])
    from_element(doc)
  end
end
