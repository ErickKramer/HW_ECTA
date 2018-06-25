function pop = NSGA2()
%% Initialize
    clear all; clc;
    p.nGenes    = 20; % > feval evaluates a function. we have 
                                 %   programmed our fitness functions to 
                                 %   return the number of genes when no
                                 %   input arguments are given to make it
                                 %   easier to switch between tasks.
    p.maxGen    = 200;
    p.popSize   = 100;
    p.sp        = 2;
    p.crossProb = 0.8;
    p.mutProb   = 1/p.nGenes;
    p.elitePerc = 0.1;
    output      = p;  
    
    
    for iGen = 1:p.maxGen    
    %% Initialize population
    % - Initialize a population of random individuals and evaluate them.
        if iGen == 1
            pop              = randi([0 1],[p.popSize p.nGenes]); % (range, matrix dimensions)
        end
            fitness_ones     = trailing_ones_fitness(pop);  
            fitness_zeros   =  leading_zeros_fitness(pop); 
            [individuals, F] = FNDS(pop, p, fitness_ones, fitness_zeros);
            
            % Crowding distance
            individuals = crowding_distance(F, individuals, fitness_ones, fitness_zeros);
            
            % Selection -- Returns [MX2] indices of parents
            parentIds = my_selection(p, individuals); % Returns indices of parents
                
            % Crossover -- Returns children of selected parents
            children  = my_crossover(pop, parentIds, p);
             
            % Mutation  -- Applies mutation to newly created children
            children  = my_mutation(children, p);
            
            % Recombination
            R = [pop; children]; 
            
            % New fitness calculation
            fitness_ones     = leading_ones_fitness(R);  
            fitness_zeros   = trailing_zeros_fitness(R);
            [individuals, F] = FNDS(R, p, fitness_ones, fitness_zeros);
        
            % Crowding distance
            individuals = crowding_distance(F, individuals, fitness_ones, fitness_zeros);
            
            %Sort individuals
            sorted_individuals = sort_individuals(individuals(1:100));
            
            % Collecting only 100 individuals
            pop = reshape([sorted_individuals.gen], [p.popSize,p.nGenes]);
            
            
            % Visualization
            fitness_ones     = trailing_ones_fitness(pop);  
            fitness_zeros   =  leading_zeros_fitness(pop);
%             displayFronts([sorted_individuals.rank], [fitness_ones, fitness_zeros], pop);
%             pause(0.5);
            iGen = iGen +1;
        
        
        
        
        
    end
end

%     % Data Gathering
%     [fitMax(iGen), iBest] = max(fitness); % 1st output is the max value, 2nd the index of that max value
%     fitMed(iGen)          = median(fitness);
%     best(:,iGen)          = pop(iBest,:);
%     end
% %     pop = FNDS(pop, p, fitness)
%     
%     %% Evolutionary Operators
%     
%     % Selection -- Returns [MX2] indices of parents
%     parentIds = my_selection(fitness, p); % Returns indices of parents
%     
%     % Crossover -- Returns children of selected parents
%     children  = my_crossover(pop, parentIds, p);
%     
%     % Mutation  -- Applies mutation to newly created children
%     children  = my_mutation(children, p);
%     
%     % Elitism   -- Select best individual(s) to continue unchanged
%     eliteIds  = my_elitism(fitness, p);
%     
%     % Create new population -- Combine new children and elite(s)
%     newPop    = [pop(eliteIds,:); children];
%     pop       = newPop(1:p.popSize,:);  % Keep population size constant
%     
%     % Evaluate new population
%         fitness_ones     = leading_ones_fitness(pop, p);  
%         fitness_zeros   = trailing_zeros_fitness(pop, p);
%         fitness = fitness_ones+fitness_zeros;
% 
%     end
% output.fitMax   = fitMax;
% output.fitMed   = fitMed;
% output.best     = best;    
% end
