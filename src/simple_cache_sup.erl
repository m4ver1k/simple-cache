%%%-------------------------------------------------------------------
%% @doc simple_cache top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(simple_cache_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, simple_cache_app).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: #{id => Id, start => {M, F, A}}
%% Optional keys are restart, shutdown, type, modules.
%% Before OTP 18 tuples must be used to specify a child. e.g.
%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    SupFlags=#{
        strategy =>one_for_one,
        intensity =>4,
        period =>3200
    },
    Child=[
        #{
            id => simple_cache_worker,
            start => { simple_cache, start_link,[] },
            restart => permanent,
            shutdown =>2000,
            type => worker,
            modules =>[ simple_cache ]
        }
    ],
    {ok, {SupFlags,Child} }.

%%====================================================================
%% Internal functions
%%====================================================================
