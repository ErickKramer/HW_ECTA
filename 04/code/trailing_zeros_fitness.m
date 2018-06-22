function fitness = trailing_zeros_fitness(pop, p)

fitness = zeros(p.popSize, 1);

    for i = 1:p.popSize
        individual = pop(end, :);
        score_zeros = 0;
        for gene= p.nGenes:-1:1
            if gene ~= 1
            for neigh=(gene-1)
                if individual(gene) == individual(neigh) == 0
                    score_zeros = score_zeros + 1;
                end
            end
            end
        end
        fitness(i) = score_zeros;
    end
end