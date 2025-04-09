function [WT_norm, WT_raw, err] = getWTbyBlock(rat, gitdir)
% Get wait time (time to opt-out) by block type averaged across
% sessions for a rat

rat = upper(rat);
filepath = fullfile(gitdir, 'behavior_temporalwagering/data/A_structs', ...
    strcat('ratTrial_', rat));
load(filepath, 'A');

rew = 1:5; % 5 reward options are available in the task
blocks = 1:3; % 3 block types (1=mixed/2=high/3=low)
A.reward = convert_rew(A.reward); % convert reward from uL to nominal values

wt = nan(length(blocks), length(rew));
er = nan(length(blocks), length(rew));
for j = 1:length(rew)
    for k = 1:length(blocks)
        ix = find(A.reward==rew(j) & A.block==blocks(k) & A.optout==1 ...
            & A.catch==1);
        wt(k,j) = mean(A.wait_time(ix), 'omitnan');
        er(k,j) = sem(A.wait_time(ix));
    end
end

WT_raw.high = wt(2,:);
err.high = er(2,:);
WT_raw.mixed = wt(1,:);
err.mixed = er(1,:);
WT_raw.low = wt(3,:);
err.low = er(3,:);

% normalize wait time by 20uL in mixed block
norm = WT_raw.mixed(3);
WT_norm.high = WT_raw.high / norm;
WT_norm.mixed = WT_raw.mixed / norm;
WT_norm.low = WT_raw.low / norm;


end

function converted = convert_rew(rewardvector)

    converted = rewardvector;
    
    converted(converted==4) = 1;
    converted(converted==5) = 1;
    converted(converted==8) = 2;
    converted(converted==10) = 2;
    converted(converted==16) = 3;
    converted(converted==20) = 3;
    converted(converted==32) = 4;
    converted(converted==40) = 4;
    converted(converted==64) = 5;
    converted(converted==80) = 5;

end