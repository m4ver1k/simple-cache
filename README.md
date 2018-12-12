simple_cache
=====

A Simple in memory KV/Cache Server Application. Uses Erlang Maps to store data.

`simple_cache` is a OTP `Application` with one top level supervisor and a worker `gen_server`. The gen_server (registered with name `simple_cache`) is the where all the code for cache reside.

A client API module wraps all `OTP API` called `cache_client` and expose a simple API to use the application.

Build
-----
    $ rebar3 compile

Test
----
    $ rebar3 eunit

Basic Usage
-----------

```
1> l(cache_client).
{module,cache_client}
2> cache_client:start().
ok
3> cache_client:put(key,"value").
ok
4> cache_client:get(key).
"value"
5> cache_client:delete(key).
ok
6> cache_client:get(key).   
undefined
```