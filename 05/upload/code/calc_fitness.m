function fitness = calc_fitness(wMat)
totalSteps = 1000;
initialState = [0 0 .017 0 0.0 0]';  % initial state (note, it is a column vector) (1 degree = .017 rad)
scaling = [ 2.4 10.0 0.628329 5 0.628329 16]'; % Divide state vector by this to scale state to numbers between 1 and 0
state = initialState;
force = 10;
nSample =1;
nInputs = length(state); 
nHidden = 3; 
nOutputs = 1; 
nNode = nInputs+nHidden+nOutputs;
for step=1:totalSteps    
    %% Check that all states are legal
    onTrack = abs(state(1)) < 2.16;
    notFast = abs(state(2)) < 1.35;
    pole1Up = abs(state(3)) < pi/2;
    pole2Up = true;%abs(state(5)) < pi/2;
    failureConditions = ~[onTrack notFast pole1Up pole2Up];
    if any(failureConditions)   
        fitness = step; break;
    else % Do the next time step
        %% ACTION SELECTION [your code goes here]
        scaledInput = state./scaling; % Normalize state vector for ANN
        inputVector = scaledInput';

        nodeAct = zeros(nSample,nNode);
        nodeAct(1:nInputs) = inputVector;

        for iNode = (nInputs+1):nNode
            % Here we compute the activation of a node by applying only the 
            % relevant column of the weight matrix, and then apply the
            % activation function, in this case 'tanh', to the result.
           nodeAct(iNode) = tanh(nodeAct*wMat(:,iNode)); 
        end
        output = nodeAct(end);
        action = output*force; % Scale to full force
        
        %% SIMULATE RESULT
        % Take action and return new state:
        state = cart_pole2( state, action );   
        end
    end
end

