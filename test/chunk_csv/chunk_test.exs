defmodule ChunkTest do
  use ExUnit.Case
  use ExSpec, async: true
  alias ChunkCSV.Chunk
  doctest ChunkCSV.Chunk

  describe "#parse" do
    context "csv has headers" do
      it "return correctly Chunk of map" do
        lines = ["1,1,1,1\n", "2,2,2,2\n", "3,3,3,3\n"]
        headers = [:a, :b, :c, :d]
        result = Chunk.parse lines, %{headers: headers}
        assert result.headers == headers
        assert result.rows |> Enum.count == 3
        assert result.rows |> Enum.at(0) == %{a: "1", b: "1", c: "1", d: "1"}
      end
    end

    context "csv hasn't headers" do
      it "return Chunk of list" do
        lines = ["1,1,1,1\n", "2,2,2,2\n", "3,3,3,3\n"]
        result = Chunk.parse lines
        assert result.rows |> Enum.count == 3
        assert result.rows |> Enum.at(0) == ["1", "1", "1", "1"]
      end
    end

    context "seperator is not comma" do
      it "return Chunk of list" do
        lines = ["1a1a1a1\n", "2a2a2a2\n", "3a3a3a3\n"]
        result = Chunk.parse lines, %{seperator: "a"}
        assert result.rows |> Enum.count == 3
        assert result.rows |> Enum.at(0) == ["1", "1", "1", "1"]
      end
    end
  end

  describe "#parse_line" do
    it "should return same line when don't have headers" do
      line = ["el1", "el2"]
      assert Chunk.parse_line(line, nil) == line
    end

    it "should return map when have headers" do
      line = ["el1", "el2"]
      headers = [:a, :b]
      result = Chunk.parse_line(line, headers) 
      assert result[:a] == "el1"
      assert result[:b] == "el2"
    end
  end

  describe "#line_to_map" do
    it "return same map when keys is empty list" do
      map = %{a: 1}
      result = Chunk.line_to_map(map, [], [1])
      assert result == map
    end

    it "return same map when values is empty list" do
      map = %{a: 1}
      result = Chunk.line_to_map(map, [1], [])
      assert result == map
    end

    it "return map of keys and values" do
      result = Chunk.line_to_map(%{}, [:a, :b, :c], [1, 2, 3, 4])
      assert result == %{a: 1, b: 2, c: 3}
    end
  end
end