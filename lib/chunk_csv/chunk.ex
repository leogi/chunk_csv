defmodule ChunkCSV.Chunk do
  @moduledoc """
  
  """

  defstruct headers: nil, rows: %{}

  @doc """

  """
  def parse(lines, options \\ %{}) do
    rows = Enum.map(lines, fn(line) ->
      line
      |> String.trim
      |> String.split(options[:seperator] || ",")
      |> parse_line(options[:headers])
    end)

    %ChunkCSV.Chunk{headers: options[:headers], rows: rows}
  end

  @doc """
  
  """
  def parse_line(line, nil) do
    line
  end

  @doc """
  
  """
  def parse_line(line, headers) do
    line_to_map(%{}, headers, line)
  end

  @doc """
  
  """
  def line_to_map(map, [], _values) do
    map
  end

  @doc """
  
  """
  def line_to_map(map, _keys, []) do
    map
  end

  @doc """
  
  """
  def line_to_map(map, [k_head|k_tail], [v_head|v_tail]) do
    map = Map.put(map, k_head, v_head)
    line_to_map(map, k_tail, v_tail)
  end
end
