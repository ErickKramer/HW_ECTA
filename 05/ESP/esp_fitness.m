function fitness = esp_fitness(weights)
totalSteps = 10000;
initialState = [0 0 .017 0 0.0 0]';
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]';
state = initialState;
p.simParams.force=10;

for step=1:totalSteps
    % Check that all states are legal
    onTrack = abs(state(1)) < 2.16;
    notFast = abs(state(2)) < 1.35;
    pole1Up = abs(state(3)) < pi/2;
    pole2Up = abs(state(5)) < pi/2;
    failureConditions = ~[onTrack notFast pole1Up pole2Up];
    if any(failureConditions)   
        fitness = step; break;
    else
        fitness = step;
        % Do the next time step
        scaledInput = state./scaling; 
        output = rnn(scaledInput,weights);
        action = output*p.simParams.force;
        state = cart_pole3( state, action );
    end
end
end