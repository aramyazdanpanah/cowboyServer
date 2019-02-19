%%%-------------------------------------------------------------------
%% @doc cowboyServer public API
%% @end
%%%-------------------------------------------------------------------

-module(cowboyServer_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
                                      {'_', [
                                             {"/", toppage_h, []}
                                            ]}
                                     ]),
	{ok, _} = cowboy:start_clear(http, [{port, 9090}], #{
                                                         env => #{dispatch => Dispatch}
                                                        }),

    app_timer:start_link(),
    cowboyServer_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
