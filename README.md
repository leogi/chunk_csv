# ChunkCSV

ChunkCSV is elixir library for importing of csv to list of map.

```elixir
ChunkCSV.process "path/to/file.csv", %{header: true, chunk_size: 100}, fn(chunk) ->
  # chunk
  chunk.headers # return header of csv file
  chunk.rows
  |> Enum.each fn(row) ->
    # row is map if option header is true
    # %{header1: "value1", header2: "value2"}
    # or row is list if option header is false
    # ["value1", "value2"]
  end
end
```

### Fixtures
- able to process large CSV-files
- able to chunk the input from the CSV file to avoid loading the whole CSV file into memory

## Installation

The package can be installed as:

  1. Add `chunk_csv` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:chunk_csv, "~> 0.1.0"}]
    end
    ```

  2. Ensure `chunk_csv` is started before your application:

    ```elixir
    def application do
      [applications: [:chunk_csv]]
    end
    ```

