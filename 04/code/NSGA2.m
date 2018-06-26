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
    p.sp_       = 2; %Selection pressure
    p.crossProb = 0.8;
%     p.mutProb   = 1/p.nGenes;
    p.mutProb   = 0.1;
    p.elitePerc = 0.1;
    output      = p;  
    
    % Initialization of the structure data used for the problem
    test_pop = load('debug_pop.mat');    
    for it = 1:p.popSize
        individuals(it).sp = [];
        individuals(it).np = 0;
%         individuals(it).gen = randi([0 1],[1 p.nGenes]);
        individuals(it).gen = test_pop.pop(it,:) ;
        individuals(it).rank = 0;
        individuals(it).fitness = [leading_zeros_fitness(individuals(it).gen), trailing_ones_fitness(individuals(it).gen)];
        individuals(it).crowding_distance = 0;     
    end
    
    individuals = individuals';
    
    for iGen = 1:p.maxGen    
    %% Initialize population
    % - Initialize a population of random individualss and evaluate them.
%         if iGen == 1
%             pop              = randi([0 1],[p.popSize p.nGenes]); % (range, matrix dimensions)
%         end
%             fitness_ones     = trailing_ones_fitness(pop);  
%             fitness_zeros   =  leading_zeros_fitness(pop); 
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
            individuals_2(it).fitness = [leading_zeros_fitness(individuals_2(it).gen), trailing_ones_fitness(individuals_2(it).gen)];
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
        
        %Display front
%         disp(F);
        
%         individuals.fitness
        plot_pop = reshape([sorted_individuals.gen], [p.nGenes,2*p.popSize])';
%         plot_pop = vertcat(sorted_individuals.gen);
        hold on;
        displayFronts([sorted_individuals.rank]', reshape([sorted_individuals.fitness],2,[])', plot_pop);
%         displayFronts([sorted_individuals.rank]', reshape([sorted_individuals.fitness],2,[])', vertcat(sorted_individuals.gen));
        drawnow;
        hold off;
        
        
            
        % Collecting population to survive
        individuals = sorted_individuals(1:p.popSize);
        
        
        
        
    end
end