function [ITI_zs, ITI_raw, err] = getITIbyBlock(rat, gitdir)
% Get ITI (time to initiate trial) by block type averaged across
% sessions for a rat

rat = upper(rat);
filepath = fullfile(gitdir, 'behavior_temporalwagering/data/A_structs', ...
    strcat('ratTrial_', rat));
load(filepath, 'A');

l = A.ITI;
usethese = ~isnan(l);
L = l(usethese);
blk = A.block(usethese); % 1=mixed, 2=high, 3=low

% filter outliers in trial initiation time
outlier = [prctile(L,1), prctile(L,99)];
L(L<outlier(1)) = NaN;
L(L>outlier(2)) = NaN;
L_zs = (L-mean(L, 'omitnan'))./std(L, 'omitnan');

% get average ITI (both z-scored and raw) and sem error by block
ITI_raw.high = mean(L(blk==2), 'omitnan');
ITI_zs.high = mean(L_zs(blk==2), 'omitnan');
err.high = sem(L(blk==2));

ITI_raw.low = mean(L(blk==3), 'omitnan');
ITI_zs.low = mean(L_zs(blk==3), 'omitnan');
err.low = sem(L(blk==3));

ITI_raw.mixed = mean(L(blk==1), 'omitnan');
ITI_zs.mixed = mean(L_zs(blk==1), 'omitnan');
err.mixed = sem(L(blk==1));


end