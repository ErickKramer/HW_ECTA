function fitness = leading_zeros_fitness(pop)
    [~,I] = max(pop');
    fitness = I' - 1;
end