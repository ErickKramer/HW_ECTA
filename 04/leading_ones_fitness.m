function fitness = leading_ones_fitness(pop)

% fitness = zeros(p.popSize, 1);

%     for i = 1:p.popSize
%         individual = pop(i, :);
%         score_ones = 0;
%         for gene=1:p.nGenes
%             if gene~=20
%                 for neigh=(gene+1)
%                     if individual(gene) == individual(neigh) == 1
%                         score_ones = score_ones + 1;
%                     end
%                 end
%             end
%         end
%         fitness(i) = score_ones;
%     end
    [~,I] = min(pop');
    fitness = I' - 1;
end