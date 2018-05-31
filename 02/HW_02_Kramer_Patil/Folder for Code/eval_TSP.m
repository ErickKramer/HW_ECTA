%Single evaluation.
clear; clear all;
cityData = TSP_German_ver();
p = TSP_German_ver('distance_calc',cityData,0.1);
output = TSP_German_ver('distance_calc',cityData,0.1,p);
disp("done")

%% Plotting the fitness and median
plot([output.fitMax; output.fitMed]','LineWidth',3);
legend(['Min Fitness ' num2str(lowest)],'Median Fitness','Location','NorthEast');
xlabel('Generations'); ylabel('Total Distance [Coordinates]'); set(gca,'FontSize',16);
title('Performance of TSP')

%% Plotting the best individual over just one run

[lowest, ilowest] = min(output.fitMax);
smallest = output.best(:,ilowest)';

%coords = cityData.data([1:size(output.best,1)], [3 2])'; % <- switch to plot with north up after imagesc
plotTsp(smallest, cityData.coords);

%% Calculating the best individuals over 30 runs for different rates
clc; clear all;
% tic
Rates = [0.01, 0.10, 0.8, 0.99];
mutfit =[];
for  i = 1:length(Rates)
    rate = Rates(i);
    parfor iExp = 1:30
        cityData = TSP_German_ver();
        p = TSP_German_ver('distance_calc',cityData, rate);
        output = TSP_German_ver('distance_calc',cityData, rate, p);
        fitness(iExp,:) = output.fitMax;
        fit_median(iExp,:) = output.fitMed;
        [lowest, ilowest] = min(output.fitMax);
        smallest = output.best(:,ilowest)';
        best_ind{iExp} = {smallest, lowest};
    end
    cityData = TSP_German_ver();

%Extracting the values from the best_ind cells
    for idis=1:30
        distances(idis) = best_ind{idis}{2};
    end

    %Getting the best individual
    [val, iVal] = min(distances);
    best = best_ind{iVal}{1};

    %plot the best individual
%     plotTsp(best, cityData.coords);
%     disp('Press a key to continue')
%     toc
%     pause;
    close all;

    myFitness = min(fitness);
    myMedian = min(fit_median);
%     plot([myFitness; myMedian]','LineWidth',3);
%     legend('Best Fitness','Median Fitness','Location','NorthWest');
%     xlabel('Generations'); ylabel('Total Tour Distance [Coordinates space]'); set(gca,'FontSize',16);
%     title('Performance of TSP')
    mutfit(i,:) = myFitness;
    val_rate(i) = val;
    disp([num2str(Rates(i)), ' done'] )
end

%Iterating to plot the different rates
for i=1:4
    plot(mutfit(i,:), 'LineWidth',3,'DisplayName',['Rate ' num2str(Rates(i)) ' Best: ' num2str(val_rate(i))])
    xlabel('Generations'); ylabel('Total Distance [Coordinates space]'); set(gca,'FontSize',16);
    title('Performance of TSP with crossover rates')
    hold on;
end
legend