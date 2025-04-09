function plotITIbyBlock(iti, semerr)

if nargin<2
    semerr.low = sem(iti.low);
    semerr.mixed = sem(iti.mixed);
    semerr.high = sem(iti.high);
end

% set colors for blocks
cl.low = 'b';
cl.mixed = [.41 .1 .81];
cl.high = 'r';

errorbar(1, mean(iti.low, 'omitnan'), semerr.low, '_', color=cl.low, ...
    MarkerFaceColor=cl.low, linewidth=2, capsize=0);
errorbar(2, mean(iti.mixed, 'omitnan'), semerr.mixed, '_', color=cl.mixed, ...
    MarkerFaceColor=cl.mixed, linewidth=2, CapSize=0);
errorbar(3, mean(iti.high, 'omitnan'), semerr.high, '_', color=cl.high, ...
    MarkerFaceColor=cl.high, LineWidth=2, CapSize=0);

set(gca, fontsize=15, tickdir='out')
xlim([0.5 3.5])
xticks(1:3)
xticklabels({'Low', 'Mixed', 'High'})

end
