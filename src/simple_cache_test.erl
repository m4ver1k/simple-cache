-module(simple_cache_test).
-include_lib("eunit/include/eunit.hrl").
-define(CACHE,simple_cache).

cache_test_()->
    {
        setup,
        fun start/0,
        fun stop/1,
        fun test_cache/1
    }.

test_cache(_Pid)->
    [
        ?_assertEqual(undefined,cache_client:get("Name")),
        ?_assertEqual(ok,cache_client:put("Name","M4ver1k")),
        ?_assertEqual("M4ver1k",cache_client:get("Name")),
        ?_assertEqual(ok,cache_client:delete("Name")),
        ?_assertEqual(undefined,cache_client:get("Name"))
    ].

start()->
    simple_cache:start_link().

stop(_) ->
    simple_cache:stop(?CACHE).
