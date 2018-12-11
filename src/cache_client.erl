-module(cache_client).

-export([
    put/3,
    get/2,
    delete/2
]).

-export([ start/0, stop/0 ]).

put(Cache,K,V) ->
    gen_server:call(Cache,{put,K,V}).

get(Cache,K) ->
    {ok,Value}=gen_server:call(Cache,{get,K}),
    Value.

delete(Cache,K)->
    gen_server:cast(Cache,{delete,K}).

start() ->
    application:start(simple_cache).

stop() ->
    application:stop(simple_cache).