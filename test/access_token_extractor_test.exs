defmodule AccessTokenExtractorTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "access_token key value added to private in Plug.Conn struct when access_token received as params" do
    conn = call conn(:get, "/?access_token=abc")
    assert conn.private.access_token == "abc"
  end

   test "access_token key value added to private in Plug.Conn struct when access_token received as headers" do
    conn = conn(:get, "/")
      |> put_req_header("authorization", "Token token=abc")
      |> call
    IO.inspect conn.private
    assert conn.private.access_token == "abc"
  end

  test "custom key in private map of Plug.Conn struct when access_token received" do
    conn = conn(:get, "/")
      |> put_req_header("authorization", "Token token=abc")
      |> call :token
    assert conn.private.token == "abc"
    conn = call conn(:get, "/?access_token=abc"), :token
    assert conn.private.token == "abc"
  end

  defp parser_plug(conn) do
    Plug.Parsers.call(conn, Plug.Parsers.init(parsers: [Plug.Parsers.URLENCODED]))
  end

  defp call(conn) do
    conn
      |> parser_plug
      |> AccessTokenExtractor.call(AccessTokenExtractor.init([]))
  end

  defp call(conn, key) do
    conn
      |> parser_plug
      |> AccessTokenExtractor.call(AccessTokenExtractor.init([key: key]))
  end
end
