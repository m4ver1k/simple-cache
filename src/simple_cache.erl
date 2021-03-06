-module(simple_cache).
-behaviour(gen_server).

%% API
-export([stop/1, start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

-record(cache,{
        name ,
        items = #{}
}).


stop(Name) ->
   gen_server:call(Name, stop).

start_link() ->
   gen_server:start_link({local, ?MODULE}, ?MODULE, [{name,?MODULE}], []).

init(Args) ->
    
   {ok, #cache{name=proplists:get_value(name,Args,cache) }}.

handle_call(stop, _From, State) ->
   {stop, normal, stopped, State};

handle_call({get,Key},_From,Cache) ->
    {cache,_,Items}=Cache,
    Value = maps:get(Key,Items,undefined),
    {reply,{ok,Value},Cache};

handle_call({put,Key,Value},_From,Cache)->
    {cache,_,Items}=Cache,
    NewItems = maps:put(Key,Value,Items),
    {reply,ok,Cache#cache{items = NewItems} }.

handle_cast({delete,Key},Cache) ->
    {cache,_,Items} = Cache,
    NewItems = maps:remove(Key,Items),
    {noreply,Cache#cache{items = NewItems} };

handle_cast(_Msg, State) ->
   {noreply, State}.

handle_info(_Info, State) ->
   {noreply, State}.

terminate(_Reason, _State) ->
   ok.
