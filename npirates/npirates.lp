% N pirates find a treasure and decide to split it in the following way:
%
% The eldest pirate makes a proposal as to how to split the treasure.
% Then all the pirates vote whether to accept the proposal or reject it.
% If at least half of the pirates accept the proposal (including the
% proposer), then the proposal is accepted. Otherwise the eldest pirate
% goes over board and the remaining pirates repeat the process.
%
% The pirates decide only strictly logical and they will always do what
% gets them the most money immediately. What will the eldest pirate propose?

% There are seven pirates in the original formulation
#const n=7.

% We will consider pirate 1 the youngest and pirate 7 the eldest.
pirate(1..n).

% There are three categories of shares a pirate can propose:
% no share at all, a small share (i.e. one coin) or a big share (i.e.
% an even split).
better_share(bigshare, noshare).
better_share(bigshare, smallshare).
better_share(smallshare, noshare).

% Any pirate who makes a proposal will assign any size of share to the
% remaining pirates other than himself.
1{proposal(Splitter, Pirate, Share) : Share = (noshare;smallshare;bigshare)}1 :-
    pirate(Splitter),
    pirate(Pirate),
    Pirate < Splitter.

% Any pirate who makes a proposal will assign a big share to himself.
% This is a practical help in the optimization, but not strictly true
% from the problem formulation. However, as the pirates will only do
% what gets them the most money, it is hard to imagine how any one of
% them would only take a single coin or nothing.
proposal(Splitter, Splitter, bigshare) :- pirate(Splitter).

% Pirates which are older than the splitter are already over board,
% so they will not get any share at all.
proposal(Splitter, Pirate, noshare) :- 
    pirate(Splitter),
    pirate(Pirate),
    Pirate > Splitter.

% Every splitter will accept his own proposal as he doesn't want to die.
accept_proposal(Splitter, Splitter) :- pirate(Splitter).

% A pirate will accept a splitter's proposal, if the value he can
% expect from the next splitter is worse than what is proposed.
accept_proposal(Splitter, Pirate) :- proposal(Splitter, Pirate, Share),
				     expect_value(Splitter-1, Pirate, ShareIfRejects),
				     better_share(Share, ShareIfRejects).
% A pirate can expect the share which a specific splitter would propose,
% if the proposal would be accepted.
expect_value(Splitter, Pirate, Share) :-
    proposal_will_be_accepted(Splitter),
    proposal(Splitter, Pirate, Share).

% Otherwise, the expectation is determined by the next splitter.
expect_value(Splitter, Pirate, Share) :-
    proposal_will_be_rejected(Splitter),
    expect_value(Splitter-1, Pirate, Share).

% A proposal will be accepted if at least half of the remaining pirates
% accepts it.
proposal_will_be_accepted(Splitter) :- pirate(Splitter),
				       N = #count { Pirate : accept_proposal(Splitter, Pirate) },
				       N * 2 >= Splitter.

% Otherwise, it will be rejected.
proposal_will_be_rejected(Splitter) :- pirate(Splitter),
				       not proposal_will_be_accepted(Splitter).

% The cost of a proposal (from the perspective of the splitter) is
% determined by what shares he gives away. For the sake of optimization,
% we can assume that a big share is n coins.
proposal_cost(Splitter, Pirate, 0) :- proposal(Splitter, Pirate, noshare), Pirate != Splitter.
proposal_cost(Splitter, Pirate, 1) :- proposal(Splitter, Pirate, smallshare), Pirate != Splitter.
proposal_cost(Splitter, Pirate, n) :- proposal(Splitter, Pirate, bigshare), Pirate != Splitter.

% Since pirates act only logical, no pirate will make an offer which
% will be rejected.
:- pirate(Splitter), proposal_will_be_rejected(Splitter).

% Every splitter seeks to minimize the cost of his proposal, so that the
% largest share remains for himself.
#minimize { Cost,Splitter,Pirate : proposal_cost(Splitter, Pirate, Cost) }.

% Helper predicate to select the proposal we want to see
query(proposal(Splitter, Pirate, Share)) :- proposal(Splitter, Pirate, Share), Splitter=n.

#show query/1.

% Test run:
%
%%  $ clingo npirates.lp -c n=7
%%  clingo version 5.1.0
%%  Reading from npirates.lp
%%  Solving...
%%  Answer: 1
%%  query(proposal(7,7,bigshare)) query(proposal(7,1,smallshare)) query(%%  proposal(7,2,noshare)) query(proposal(7,3,smallshare)) query(proposal(7,4,noshare)) query(proposal(7,5,smallshare)) query(proposal(7,6,noshare))
%%  Optimization: 9
%%  OPTIMUM FOUND
%%  
%%  Models       : 1
%%    Optimum    : yes
%%  Optimization : 9
%%  Calls        : 1
%%  Time         : 0.008s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
%%  CPU Time     : 0.000s
