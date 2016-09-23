defmodule ChunkCSV do
  @moduledoc """
  
  """

  alias ChunkCSV.Chunk

  @doc """
  
  """
  def process filepath, options \\ %{}, handler do
    stream = File.stream!(filepath)

    headers = if options[:header], do: get_header(stream), else: nil
    offset = if options[:header], do: 1, else: 0
    options = Map.put(options, :headers, headers)

    process_chunk(stream, handler, offset, options)
  end

  @doc """
  
  """
  def process_chunk stream, handler, offset, options \\ %{} do
    size = options[:chunk_size] || 1000

    chunk = stream
      |> Enum.slice(offset, size)
      |> Chunk.parse(options)

    handler.(chunk)

    if chunk.rows != [] do
      process_chunk(stream, handler, size + offset, options)
    end
  end

  @doc """
  
  """
  def get_header stream, options \\ %{} do
    stream
    |> Enum.at(0)
    |> String.trim
    |> String.split(options[:seperator] || ",")
    |> Enum.map(fn(header) -> String.to_atom(header) end)
  end
end
