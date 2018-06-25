function sorted_individuals = sort_individuals(individuals)
    [v_rank,I_rank] = sort([individuals.rank]);
    for i=1:size(I_rank,2)-1
        if v_rank(i) == v_rank(i+1)
            cr_ds_1 = individuals(I_rank(i)).distance;
            cr_ds_2 = individuals(I_rank(i+1)).distance;
            if cr_ds_2 < cr_ds_1
                [I_rank(i+1), I_rank(i)] = deal(I_rank(i), I_rank(i+1));
            end
        end
    end
    sorted_individuals = individuals(I_rank);
end