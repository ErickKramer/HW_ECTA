function individual =  crowding_distance(F, individual, fitness_ones, fitness_zeros)

    for fr= 1:size(F,2) 
        
        % Extract front_ind in the front
        front_ind = [F{fr}];
        
        % Initialize the distance to be zero
        for ind=1:numel(front_ind)
            individual(front_ind(ind)).distance = 0;                   
        end
        
        % Sort by fitness
        [sorted_ones,I_ones] = sort(fitness_ones(front_ind));
        [sorted_zeros,I_zeros] = sort(fitness_zeros(front_ind));
        
        % Assign infinite distance to boundaries
        individual(front_ind(I_ones(1))).distance = inf;
        individual(front_ind(I_ones(end))).distance = inf;
        
        individual(front_ind(I_zeros(1))).distance = inf;
        individual(front_ind(I_zeros(end))).distance = inf;
        
        for k = 2:size(front_ind,1) - 1
            if (max(sorted_ones) - min(sorted_ones)) ~= 0
                individual(I_ones(k)).distance = individual(I_ones(k)).distance + ...
                    (fitness_ones(I_ones(k+1)) - fitness_ones(I_ones(k-1))/...
                    (max(sorted_ones) - min(sorted_ones)));
            end
            if (max(sorted_zeros) - min(sorted_zeros)) ~= 0
                individual(I_zeros(k)).distance = individual(I_zeros(k)).distance + ...
                    (fitness_zeros(I_zeros(k+1)) - fitness_zeros(I_zeros(k-1))/...
                    (max(sorted_zeros) - min(sorted_zeros)));
            end
        end
        
        
        
        
        
        
        
        
        
    end
end