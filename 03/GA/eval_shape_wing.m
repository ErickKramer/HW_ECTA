%% Evaluating the real value representation
clc; clear all;
tic
wing = shape_real_GA();
p = shape_real_GA('mean_square_mul', wing);
output = shape_real_GA('mean_square_mul', wing, p);
disp("Foil calculated")
toc

%% Plotting fitness
plot([output.fitMax; output.fitMed]','LineWidth',3);
legend('Min Fitness','Median Fitness','Location','NorthWest');
xlabel('Generations'); ylabel('Mean square error'); set(gca,'FontSize',16);
title('Performance of Shape formation')

%% Calculating the best individual
[lowest, ilowest] = min(output.fitMax);
smallest = output.best(:,ilowest)';

%% Plotting the best individual
plot_foil(smallest', wing)

%NOTE: Pending finding the right parameters to improve performance. 

%% Evaluating bitstring representation
clc; clear all;
wing = shape_bitstring_GA();
p = shape_bitstring_GA('mean_square_mul', wing);
output = shape_bitstring_GA('mean_square_mul', wing, p);
disp("Foil calculated")

%% Calculating the best individuals over 20 runs for different rates real values
clc; clear all;

parfor iExp = 1:20
    wing = shape_real_GA();
    p = shape_real_GA('mean_square_mul', wing);
    output = shape_real_GA('mean_square_mul', wing, p);
    fitness(iExp,:) = output.fitMax;
    fit_median(iExp,:) = output.fitMed;
    [lowest, ilowest] = min(output.fitMax);
    best = output.best(:,ilowest)';
    best_ind{iExp} = {best, lowest};
end
wing = shape_real_GA();


%Extracting the values from the best_ind cells
for iPen=1:20
    penalizations(iPen) = best_ind{iPen}{2};
end

%Getting the best individual
[val, iVal] = min(penalizations);
smallest = best_ind{iVal}{1};

plot_foil(smallest', wing)

pause;
close all;

myFitness = mean(fitness);
myMedian = mean(fit_median);
plot([myFitness; myMedian]','LineWidth',3);
legend('Mean Fitness','Median Fitness','Location','NorthEast');
xlabel('Generations'); ylabel('Penalization'); set(gca,'FontSize',16);
title('Performance of shape matching of a wing')