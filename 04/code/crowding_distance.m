function individual =  crowding_distance(F, individual, fitness_ones, fitness_zeros)
    for fr= 1:size(F,2) 
        
        % Extract front_ind in the front
        front_ind = [F{fr}];
        
        % Initialize the distance to be zero
        for ind=1:numel(front_ind)
            individual(front_ind(ind)).distance = 0;                   
        end
        
        % Sort by fitness
        [~,I_ones] = sort(fitness_ones(front_ind));
        [~,I_zeros] = sort(fitness_zeros(front_ind));
        
        % Assign infinite distance to boundaries
        individual(front_ind(I_ones(1))).distance = inf;
        individual(front_ind(I_ones(end))).distance = inf;
        
        individual(front_ind(I_zeros(1))).distance = inf;
        individual(front_ind(I_zeros(1))).distance = inf;
        
        for k = 2:size(front_ind,1) - 1
            if max(fitness_ones(front_ind)) - min(fitness_ones(front_ind)) ~= 0
                individual(I_ones(k)).distance = individual(I_ones(k)).distance + ...
                    (fitness_ones(I_ones(k+1)) - fitness_ones(I_ones(k-1))/...
                    (max(fitness_ones(front_ind)) - min(fitness_ones(front_ind))));
            end
            if max(fitness_zeros(front_ind)) - min(fitness_zeros(front_ind)) ~= 0
                individual(I_zeros(k)).distance = individual(I_zeros(k)).distance + ...
                    (fitness_zeros(I_zeros(k+1)) - fitness_zeros(I_zeros(k-1))/...
                    (max(fitness_zeros(front_ind)) - min(fitness_zeros(front_ind))));
            end
        end
        
        
        
        
        
        
        
        
        
    end
end