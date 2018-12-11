-module(simple_cache_test).
-include_lib("eunit/include/eunit.hrl").
-define(Cache,simple_cache).

cache_test_()->
    {
        setup,
        fun start/0,
        fun stop/1,
        fun test_cache/1
    }.

test_cache(_Pid)->
    [
        ?_assertEqual(undefined,cache_client:get(?Cache,"Name"))
    ].

start()->
    simple_cache:start_link(?Cache).

stop(Pid) ->
    simple_cache:stop(?Cache).