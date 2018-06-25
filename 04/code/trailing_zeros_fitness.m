function fitness = trailing_zeros_fitness(pop)

    flipped_pop = fliplr(pop);
    [~,I] = max(flipped_pop');
    fitness = I' - 1;
end