function parentIds = my_selection(p, individuals)
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
% [~, fit_idx] = min(fitness(rand_fit));

for i= 1:size(rand_fit,2)
    if individuals(rand_fit(1,i)).rank < individuals(rand_fit(2,i)).rank || ...
       (individuals(rand_fit(1,i)).rank == individuals(rand_fit(2,i)).rank && ...
       individuals(rand_fit(1,i)).distance > individuals(rand_fit(2,i)).distance)
        fit_idx(i) = 1;
    else
        fit_idx(i) = 2;
    end
%     [~, fit_idx(i)] = min([individuals(rand_fit(1,i)).rank, individuals(rand_fit(2,i)).rank ]);
end

%Create the parentIds array with the index of the maximum values of the
%rand_fit array. 
for i=1:length(rand_fit)
    parentIds(i) = rand_fit(fit_idx(i),i);
end
%------------- END OF CODE --------------
end