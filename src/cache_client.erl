-module(cache_client).

-export([
    put/2,
    get/1,
    delete/1
]).

-export([ start/0, stop/0 ]).

-define(CACHE,simple_cache).

put(K,V) ->
    gen_server:call(?CACHE,{put,K,V}).

get(K) ->
    {ok,Value}=gen_server:call(?CACHE,{get,K}),
    Value.

delete(K)->
    gen_server:cast(?CACHE,{delete,K}).

start() ->
    application:start(?CACHE).

stop() ->
    application:stop(?CACHE).