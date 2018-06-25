function fitness = leading_ones_fitness(pop)

    [~,I] = min(pop');
    fitness = I' - 1;
end