function sorted_population = FNDS(pop, p, fitness)
%% function to perform fast non dominated sort
for i =1:p.popSize
    Sp = nan(size(pop))                        %Sp is the set of dominated solutions for an individual 'p'
%   individual = pop(i, :);
    Np = 0;                         %Np is the domination count, keeps track of the number of dominated solutions
    for j = 1:len(Sp)
        q = Sp(j,:)
        if fitness(i) > fitness(j)
            Sp(i,:) = q
    end
end
end
