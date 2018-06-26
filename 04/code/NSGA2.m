function pop = NSGA2()
%% Initialize
    clear all; clc;
    p.nGenes    = 20; 
    p.maxGen    = 200;
    p.popSize   = 1000;
    p.sp_       = 2; %Selection pressure
    p.crossProb = 0.8;
%     p.mutProb   = 1/p.nGenes;
    p.mutProb   = 0.1;
    p.elitePerc = 0.1;
    output      = p;  
    num_fitness = 3;
    
    % Initialization of the structure data used for the problem
    for it = 1:p.popSize
        individuals(it).sp = [];
        individuals(it).np = 0;
        individuals(it).gen = randi([0 1],[1 p.nGenes]);
        individuals(it).rank = 0;
        if num_fitness == 2
            individuals(it).fitness = [leading_zeros_fitness(individuals(it).gen), trailing_ones_fitness(individuals(it).gen)];
        else
            individuals(it).fitness = [leading_zeros_fitness(individuals(it).gen), trailing_ones_fitness(individuals(it).gen), non_consec_ones_zeros(individuals(it).gen)];
        end
        individuals(it).crowding_distance = 0;     
    end
    
    individuals = individuals';
    
    for iGen = 1:p.maxGen
        tic

        [individuals, F] = FNDS(individuals);
            
        % Crowding distance
        individuals = crowding_distance(F, individuals);
            
        % Selection -- Returns [MX2] indices of parents
        parentIds = my_selection(p, individuals); % Returns indices of parents
        
        % Getting the population array for crossover
        pop = reshape([individuals.gen], [p.nGenes, p.popSize])';
        
        % Crossover -- Returns children of selected parents
        children  = my_crossover(pop, parentIds, p);
             
        % Mutation  -- Applies mutation to newly created children
        children  = my_mutation(children, p);
            
        % Recombination
        
        
        for it = 1:p.popSize
            individuals_2(it).sp = [];
            individuals_2(it).np = 0;
            individuals_2(it).gen = children(it,:);
            individuals_2(it).rank = 0;
            if num_fitness ==2
                individuals_2(it).fitness = [leading_zeros_fitness(individuals_2(it).gen), trailing_ones_fitness(individuals_2(it).gen)];
            else
                individuals_2(it).fitness = [leading_zeros_fitness(individuals_2(it).gen), trailing_ones_fitness(individuals_2(it).gen), non_consec_ones_zeros(individuals_2(it).gen)];
            end
            individuals_2(it).crowding_distance = 0;     
        end
        
%         individuals_2 = individuals_2';
        
        % R = [P; Q]: Recombination aka mihir said that        
        individuals = [individuals; individuals_2']; 
        
        [individuals, F] = FNDS(individuals);
        
        
        % Crowding distance
        individuals = crowding_distance(F, individuals);
            
        %Sort individualss
        sorted_individuals = sort_individuals(individuals);
        
        
        % Plot the front
        plot_pop = reshape([sorted_individuals.gen], [p.nGenes,2*p.popSize])';
        hold on;
        displayFronts([sorted_individuals.rank]', reshape([sorted_individuals.fitness],num_fitness,[])', plot_pop);
        drawnow;
        hold off;
        
  
        % Collecting population to survive
        individuals = sorted_individuals(1:p.popSize);
        
        disp(['Generation: ' num2str(iGen)])
        disp(['1 Gen took ' num2str(toc) ' seconds'])
        
        
        
        
    end
end