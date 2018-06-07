function oneFifthES()
        %Parameters for the wing
        wing.numEvalPts = 256;
        wing.nacaNum = [0,0,1,2];
        % wing.nacaNum = [5,5,2,2]; % NACA Parameters
        % wing.nacaNum = [9,7,3,5]; % NACA Parameters
        wing.nacafoil= create_naca(wing.nacaNum,wing.numEvalPts);  % Create foil
        
        nGenes = 32;
        task = 'mean_square';
        % Es parameters

        gamma = (20/17)^(1/nGenes);
        s = 0; 
        
        t = 0; %time
                
        p = 5; %period of time
        
        mean = zeros(nGenes,1);
        
        variance = ones(nGenes,1);
        
        step_size = 0.2;
        
        individual = rand(nGenes,1)-0.5;
        stop_criteria = true;
        tic
        while(stop_criteria)
            Z = normrnd(mean, variance);  
            
            temp_individual = individual + step_size.*Z;
            
            [foil, ~] = pts2ind(individual, wing.numEvalPts);
            [temp_foil, ~] = pts2ind(temp_individual, wing.numEvalPts);
            fitness = feval(task, wing, foil); 
            temp_fitness = feval(task, wing, temp_foil);
            
            if temp_fitness <= fitness
                s = s+1;
                individual = temp_individual;
            end
            
            if mod(t,p) == 0
                if s/p < 0.2
                    step_size = step_size/gamma;
                else
                    step_size = step_size*gamma;
                end
                s = 0;
            end
            t = t+1;
        %Plotting progress
        plot_foil(individual, wing)
        pause(0.5);
        if fitness < 0.00002
            stop_criteria = false;
        end
       toc
end
