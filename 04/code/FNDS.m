function individual = FNDS(pop, p, fitness_ones, fitness_zeros)
% function to perform the non-dominated sort
%% initialize the variables 
F{1} = [];

%% begin the sorting procedure, obtain the values for Sp and Np for each solution
for ip = 1:p.popSize
    individual(ip).sp = [];
    individual(ip).np = 0;
    for iq = 1:p.popSize
        if ip ~= iq
            if dom_validator(ip, iq, fitness_ones, fitness_zeros)
                individual(ip).sp = [individual(ip).sp; iq];
            elseif dom_validator(iq, ip, fitness_ones, fitness_zeros)
                individual(ip).np = individual(ip).np + 1;
            end
        end
    end
    
    if individual(ip).np == 0
        individual(ip).rank = 1;
        F{1} = [F{1}; ip];
    end
    
end   

%% calculate pareto rank of each individual
iFront = 1;
while true
    Q = [];
    
    for i=1:numel(F{iFront})
        p = individual(F{iFront}(i));
        for j = 1:numel(p.sp)
            q = individual(p.sp(j));
            q.np = q.np - 1;
            
            if q.np == 0
                q.rank = iFront + 1;
                Q = [Q; p.sp(j)];
            end
            individual(p.sp(j)) = q;           
        end
    end
    
    if isempty(Q)
        break;
    end
    
end
end