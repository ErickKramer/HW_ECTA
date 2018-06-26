function dominates = dom_validator(ind_A, ind_B, fitness_ones, fitness_zeros)
    % Validate if ind_A dominate ind_B
    
%     if (fitness_ones(ind_A) > fitness_ones(ind_B) && ...
%        fitness_zeros(ind_A) >= fitness_zeros(ind_B) || ...
%        fitness_zeros(ind_A) > fitness_zeros(ind_B) && ...
%        fitness_zeros(ind_A) >= fitness_zeros(ind_B))
%        dominates = true;
%     else
%         dominates = false;
%     end
    
    ind_A_fit = [fitness_zeros(ind_A), fitness_ones(ind_A)];
    ind_B_fit = [fitness_zeros(ind_B), fitness_ones(ind_B)];
    dominates = (all(ind_A_fit >= ind_B_fit) && ...
                 any(ind_A_fit > ind_B_fit));
    
   
end