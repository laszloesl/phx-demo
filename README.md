# Demo

A small project to demonstrate how Phoenix channels may be used.

## How do I start with a Phoenix app?

```
mix phx.new demo --no-html --no-webpack --no-gettext --no-ecto
```

This will help us keep the app small and maintanable while getting rid of stuff we would never use. Perhaps the `--no-ecto` flag may be left out if we're sure that we'll need to use a database.

Then I immediately go in to `config/*.exs` and change `use Mix.Config` to `import Config` as that's the standard in latest Elixir.

I also remove all the comments, since they are like "You don't say":
```
# Configures the endpoint
config :demo, DemoWeb.Endpoint,
  ...
```

Then I remove all the `prod.secret.exs` stuff, because Elixir has a better support for release configs: [https://elixir-lang.org/getting-started/mix-otp/config-and-releases.html]

I actually don't leave too much of the config Phoenix generated, because it enforces bad practices. That's how I usually treat it:

- `config.exs` is where the main part of the configuration is with `dev` defaults
- this way I don't really need a `dev.exs`, but I like the convenience of `import_config "#{Mix.env()}.exs"`, so I just leave the file empty (except for the `import Config` line)
- if I need some other config for testing, then put it in `test.exs`
- `prod.exs` holds anything that's related to production and not a secret
- I deal with secrets through Elixir releases mentioned above

I then remove most of the comments from the files in parallel to a cleanup.

Delete the `<app_name>.ex`, because it's empty and of no use. Plain noise. I usually get rid of the `ErrorView` (note that it's also referenced in the config) and, in fact, all the views, because I'm not doing any actual FE. While we're there, delete the `controllers` directory and remove all the unnecessary part from `demo_web.ex`. And there's the static files exposed in the generated `DemoWeb.Endpoint`. I've got no statics, so I remove them. I'd also get rid of the sessions stuff, because again, it assumes my app is going to be used from a browser. I removed `Plug.Head` and `Plug.MethodOverride` from my endpoint, because I don't need them right now, maybe never.

Since we removed `ErrorView`, we have to handle errors somehow. For start, we can add `use Plug.ErrorHandler` to our router (make sure to put it before `use Phoenix.Router`) and implement a generic `handle_errors/2` call inside it.

Now we can also remove most of the `test` directory. Leave `support` and `test_helper.exs`. Then I run mix test to see if it all compiles. It does.

Finally I initialize the Elixir release with `mix release.init`, then immediately remove `env.bat.eex`, because of reasons. Then add `config/releases.exs` with whatever secret we have (currently it's the endpoint secret key base).

I lied, I also make sure to fetch the endpoint's port and hostname from the environment.

Now test if the application can be released.

```
MIX_ENV=prod mix release
SECRET_KEY_BASE=$(mix phx.gen.secret) PORT=8888 _build/prod/rel/demo/bin/demo start_iex
```

works like a charm.
