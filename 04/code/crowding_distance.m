function individuals =  crowding_distance(F, individuals)
    nFitness = 2;
    for fr= 1:size(F,2) 
          
%          for i = 1:numel(F{fr})
%              individuals(F{fr}(i)).crowding_distance = 0;
%          end
%          
%          fitness_array = reshape([individuals(F{fr}).fitness],2,[]);
%          
%          D = zeros(size(fitness_array));
%          
%          for m = 1:2
%              [sorted idx] = sort(fitness_array(m,:));
%              
%              first_idx = idx(1);
%              last_idx = idx(end);
%              
%              D(m,first_idx) = inf;
%              D(m,last_idx) = inf;
%              
%              for k = 2:numel(idx)-1
%                  D(m,k) = D(m,k) + (sorted(k+1) - sorted(k-1)) / ...
%                      (max(sorted) - min(sorted));
%              end
%          end
%          
%          D(isnan(D)) =0;
%          D = sum(D,1);
%          
%          for i=1:numel(F{fr})
%              individuals(F{fr}(i)).crowding_distance = D(i);
%          end
          
        % Extract front_ind in the front
        front_ind = [F{fr}];
        
%         % Initialize the distance to be zero
        for ind=1:numel(front_ind)
            individuals(front_ind(ind)).crowding_distance = 0;                   
        end
        
        %Collected the fitness from the individuals in the front
        fitness_front = reshape([individuals(front_ind).fitness], nFitness,[])';
        
        for m = 1:nFitness
            
            %Sort the values of the individuals in the front based on the
            %fitness
            [sorted_val, idx] = sort(fitness_front(:,m));
            
            %Set crowding distance of the boundary individuals to inf
            individuals(front_ind(idx(1))).crowding_distance = inf;
            individuals(front_ind(idx(end))).crowding_distance = inf;
            
            % Iterate over each fitness function and update the
            % corresponding crowding distance
            for k = 2:numel(idx) - 1
                if (max(sorted_val) - min(sorted_val)) ~= 0
                    individuals(front_ind(idx(k))).crowding_distance= ...
                        individuals(front_ind(idx(k))).crowding_distance + ...
                        (sorted_val(k+1) - sorted_val(k-1)) / ...
                        (max(sorted_val) - min(sorted_val));
                end
            end
        end   
    end
end