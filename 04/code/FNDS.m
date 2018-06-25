function [individuals, Front] = FNDS(pop, p, fitness)
% function to perform the non-dominated sort
%% initialize the variables 
f_count = 1;
Front(1).f = [];
for i = 1:p.popSize
    individual(i).fitness = fitness(i);
    individual(i).Sp = [];
    individual(i).Np = nan;
    individual(i).val = pop(i, :);
end

%% begin the sorting procedure, obtain the values for Sp and Np for each solution
for i = 1:p.popSize-1
    for j = i+1:p.popSize
        if individual(i).fitness > individual(j).fitness
            individual(i).Sp = [individual(i).Sp, individual(j).val]
        end
        if individual(j).fitness > individual(i).fitness
            individual(i).Np = individual(i).Np + 1;
        end
    end
end   
%% perform the sorting based on the values obtained previously

for idx = 1:p.popSize
    if individual(i).Np == 0
        individual(i).rank = 1;
        Front(1).f = [Front(1).f, i]
    end
end

%% calculate pareto rank of each individual

while( ~isempty(Front(f_count).f) )
    Q = [];
    for p = Front(f_count).f
        for q = individual(p).Sp
            individual(q).Np = individual(q).Np -1;
            if( individual(q).Np == 0 )
                pop(q).rank = f_count+1;
                Q = [Q, q];
            end
        end
    end
    f_count = f_count + 1;
    
    Front(f_count).f = Q;
end
individuals = individual;
Front(f_count) = []; 