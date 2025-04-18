% Main script for temporal wagering behavior analysis

% Clear environment
clear; clc; close all

% (!!) change this to where you cloned the repository
gitdir = 'C:\Users\hjj296\Documents\GitHub'; 

%% 
% Load a list of rats (all rats used for fiber photometry experiments in
% this paper)
datadir = fullfile(gitdir, 'temporalbandit_behavior/data');
DArats = load(fullfile(datadir, 'ratlist_DA.mat'), 'ratList');
AChrats = load(fullfile(datadir, 'ratlist_ACh.mat'), 'ratList');
rDAgAChrats = load(fullfile(datadir, 'ratlist_rDAgACh.mat'), 'ratList');
ratList = [DArats.ratList, AChrats.ratList, rDAgAChrats.ratList];
examplerat = 'J037';
exampleratID = find(cellfun(@(x) strcmpi(x, examplerat), ratList));

% Get average z-scored ITI (time to initiate trial) by block for all rats
ITI = struct;
ITI.high = nan(length(ratList),1);
ITI.mixed = nan(length(ratList),1);
ITI.low = nan(length(ratList),1);
for rr=1:length(ratList)
    rat = ratList{rr};
    iti_rat = getITIbyBlock(rat, gitdir);
    ITI.high(rr) = iti_rat.high;
    ITI.mixed(rr) = iti_rat.mixed;
    ITI.low(rr) = iti_rat.low;
end
% For the example rat, also get raw ITI and sem error
[~, rawiti_example, semiti_example] = ...
    getITIbyBlock(ratList{exampleratID}, gitdir);

% Get average wait time (time to opt-out) by reward and block for all rats
WT = struct;
WT.high = nan(length(ratList),5);
WT.mixed = nan(length(ratList),5);
WT.low = nan(length(ratList),5);
for rr=1:length(ratList)
    rat = ratList{rr};
    wt_rat = getWTbyBlock(rat, gitdir);
    WT.high(rr,:) = wt_rat.high;
    WT.mixed(rr,:) = wt_rat.mixed;
    WT.low(rr,:) = wt_rat.low;
end
% For the example rat, also get raw wait times and sem error
[~, rawwt_example, semwt_example] = ...
    getWTbyBlock(ratList{exampleratID}, gitdir);

%% Plot results
figure
t = tiledlayout(1,4);
set(gcf, units='Inches', position=[2.5,4.5,15,4])

nexttile(1); hold on
plotITIbyBlock(rawiti_example, semiti_example);
ylabel('Time to initiate trial (s)')
subtitle('Example rat')

nexttile(2); hold on
plotITIbyBlock(ITI);
ylabel('Time to initiate trial (z-score)')
subtitle(sprintf('N = %i rats', length(ratList)))

nexttile(3); hold on
plotWTbyBlock(rawwt_example, semwt_example);
ylabel('Time to opt-out (s)')
subtitle('Example rat')

nexttile(4); hold on
plotWTbyBlock(WT);
ylabel('Fractional time to opt-out')
subtitle(sprintf('N = %i rats', length(ratList)))

