defmodule AccessTokenExtractor do
  @moduledoc """
  Simple Plug to extract access_token from request and add it to private map in Plug.Conn struct.
  Access token must be provided as query param named access_token or should be provided as authorization header

  Example:

    http://some_url.com?access_token=abc

    OR

    authorization: Token token=abc

  This plug will extract token provided in any of above ways as assign it to private map in Plug.Conn struct

  You can access it using conn.private.access_token

  'access_token' is the default key used. You can provide the custom key to used when using plug

  Example:

      def MyModule
        import Plug.Builder, only: [plug: 1]
        import AccessTokenExtractor

        # second argument is optional. By default key is access_token
        plug :AccessTokenExtractor, key: :token
      end

  In above example access_token can be retrived as conn.private.token. where conn is Plug.Conn struct
  """
  import Plug.Conn

  @spec init(list) :: atom
  def init([key: key]) when is_atom(key), do: key

  @spec init(list) :: atom
  def init([]), do: :access_token

  @spec call(Plug.t, atom) :: Plug.t
  def call(conn, key) do
    access_token = if conn.params["access_token"] do
      conn.params["access_token"]
    else
      auth_header = get_req_header(conn, "authorization")
        |> to_string
        |> String.split("=")
        |> Enum.map(&(String.strip &1))
      case auth_header do
        [_, access_token] -> access_token
        _ -> ""
      end
    end
    if access_token != "" do
      conn = put_private(conn, key, access_token)
    end
    conn
  end
end
