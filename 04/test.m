tic
X_t = [1 1 1 1 1 1 1 0 0 0 0 1 1 1 0 0 0 0 0 0]

X_t_b = fliplr(X_t)

toc
%%
pop = randi([0 1], [10, 20])

%Leading ones
[~,I] = min(pop')
leading_ones = I' - 1;

%Trailing zeros
flipped_pop = fliplr(pop);
[~,I] = max(flipped_pop');
trailing_zeros = I' - 1;


%% 

p.nGenes    = 20; 
p.maxGen    = 200;
p.popSize   = 10;
p.sp        = 2;
p.crossProb = 0.8;
p.mutProb   = 1/p.nGenes;
p.elitePerc = 0.1;
output      = p;


pop              = randi([0 1],[p.popSize p.nGenes]); % (range, matrix dimensions)
fitness_ones     = leading_ones_fitness(pop);
fitness_zeros    = trailing_zeros_fitness(pop);
fitness = fitness_ones+fitness_zeros;
F1 = [];
Sp = {};
for ip = 1:size(pop,1)
    Sp_i = [];
    np = 0;
    
    for iq = 1:size(pop,1)
        if iq ~= ip
            if fitness(ip) < fitness(iq)
                Sp_i = [Sp_i; pop(iq,:)];
            elseif fitness(iq) < fitness(ip)
                np = np +1;
            end
        end
    end
    
    if np == 0
        prank = 1;
        F1 = [F1; pop(ip,:)];
    end
    Sp{ip} = Sp_i;
end

i = 1;
while Fi ~= 0
    Q = [];
    for ip = 1:size(F1,1)
        continue
    end
    
end