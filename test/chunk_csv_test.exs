defmodule ChunkCSVTest do
  use ExUnit.Case
  use ExSpec, async: true
  doctest ChunkCSV

  describe "#process" do
    it "csv has headers" do
      handler = fn(chunk) -> 
        send self, {:ok}
      end
      filepath = "test/fixtures/sample.csv"
      ChunkCSV.process(filepath, %{header: true}, handler)

      assert_received {:ok}
    end

    it "csv hasn't headers" do
      handler = fn(chunk) -> 
        send self, {:ok}
      end
      filepath = "test/fixtures/sample.csv"
      ChunkCSV.process(filepath, %{header: false}, handler)

      assert_received {:ok}
    end
  end

  describe "#process_chunk" do
    it "read csv and return chunk" do
      headers = [:header1, :header2, :header3]
      handler = fn(chunk) -> 
        send self, {:ok}
      end
      stream = File.stream!("test/fixtures/sample.csv")
      ChunkCSV.process_chunk(stream, handler, 1, %{headers: headers})

      assert_received {:ok}
    end

    it "handle two chunk when chunk_size is 2" do
      headers = [:header1, :header2, :header3]
      handler = fn(chunk) -> 
        send self, {:ok}
      end
      stream = File.stream!("test/fixtures/sample.csv")
      ChunkCSV.process_chunk(stream, handler, 1, %{headers: headers, chunk_size: 2})

      assert_received {:ok}
    end
  end

  describe "#get_header" do
    context "seperator is comma" do
      it "return header list" do
        stream = File.stream!("test/fixtures/sample.csv")
        headers = ChunkCSV.get_header(stream)
        assert headers == [:header1, :header2, :header3]
      end
    end

    context "seperator isn'n comma" do
      it "return header list" do
        stream = File.stream!("test/fixtures/seperator.csv")
        headers = ChunkCSV.get_header(stream, %{seperator: "_"})
        assert headers == [:header1, :header2, :header3]
      end
    end
  end
end
