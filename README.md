# AccessTokenExtractor

Simple Plug to extract access_token from request and add it to private map in Plug.Conn struct.
Access token must be provided as query param named access_token or should be provided as authorization header

### SETUP

Add following dependency to mix.exs

```elixir
    defp deps do
      # Add the dependency
      [{:access_token_extractor , "~> 0.1.0"}]
    end
```

### How to provide access token

    http://some_url.com?access_token=abc

    OR in authorization headers as follows

    authorization: Token token=abc

This plug will extract token provided in any of above ways as assign it to private map in Plug.Conn struct

 You can access it using `conn.private.access_token`

### Example:

```elixir
def MyModule
  import Plug.Builder, only: [plug: 1]
  import AccessTokenExtractor

  # second argument is optional. By default key is access_token
  plug :AccessTokenExtractor, key: :token
end
```

In above example access token can be retrived as conn.private.token. where conn is Plug.Conn struct

