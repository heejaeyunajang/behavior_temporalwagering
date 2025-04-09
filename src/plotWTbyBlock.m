function plotWTbyBlock(wt, semerr)

if nargin<2
    semerr.high = sem(wt.high);
    semerr.mixed = sem(wt.mixed);
    semerr.low = sem(wt.low);
end

% set colors for blocks
cl.low = 'b';
cl.mixed = [.41 .1 .81];
cl.high = 'r';

shadedErrorBar(1:5, mean(wt.high, 1, 'omitnan'), semerr.high, ...
    'lineprops', {'color', cl.high});
shadedErrorBar(1:5, mean(wt.mixed, 1, 'omitnan'), semerr.mixed, ...
    'lineprops', {'color', cl.mixed});
shadedErrorBar(1:5, mean(wt.low, 1, 'omitnan'), semerr.low, ...
    'lineprops', {'color', cl.low});

xlim([0.5 5.5]);
set(gca, fontsize=15, tickdir='out', box='off', xTick=1:5, ...
    XTickLabels={'5'; '10'; '20'; '40'; '80'});

end