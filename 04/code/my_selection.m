function parentIds = my_selection(fitness, p)
%Selection - Returns indices of parents for crossover

% %% This is tournament selection
% % parentIds = randi(p.popSize, [p.popSize 2]);
% subset = randi(p.popSize ,[p.sp p.popSize*2]);
% [~, idx]= min(fitness(subset));
% 
% parfor i=1:(2*p.popSize)
%     %idx(i)
%     parentIds(i) = subset(idx(i), i);
% end
% 
% %------------- END OF CODE --------------


parentIds = randi(p.popSize, [p.popSize 2]);

iterations = 2;

% Array of random values from 1 till popSize
rand_fit = randi(p.popSize, [p.sp p.popSize*2]);

%Using the max over the fitness give us the [max_value (which we do not
%care), and the index of the max_value] of the pairs randomly instantiated.
[~, fit_idx] = min(fitness(rand_fit));

%Create the parentIds array with the index of the maximum values of the
%rand_fit array. 
for i=1:length(rand_fit)
    parentIds(i) = rand_fit(fit_idx(i),i);
end
%------------- END OF CODE --------------
end