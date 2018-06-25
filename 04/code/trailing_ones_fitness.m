function fitness = trailing_ones_fitness(pop)
    flipped_pop = fliplr(pop);
    [~,I] = min(flipped_pop');
    fitness = I' - 1;
end