%% This is an example call to the simulator

%% Here is how a state is defined:
%   state = [ x           <- the cart position
%             x_dot       <- the cart velocity
%             theta       <- the angle of the pole
%             theta_dot   <- the angular velocity of the pole.
%             theta2      <- the angle of the 2nd pole
%             thet2a_dot  <- the angular velocity of the 2nd pole.
%           ]

%% Initialize hyperparameters
% fig = figure(1);
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


%% Solving the pole balancing problem with neuroevolution

for step=1:totalSteps
    %Check that all states are legal
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
        
        % Output should be the response of your neural network. Here I just 
        % use a random number between 0 and 1. Put your ANN code here. 
        % Output should be between -1 (full force left) and 1 (full force right)

        % Weight Matrix       
        inputVector = scaledInput'; %transpose for matrix multiplication with the weight matrix
       
        if step == 1
            wMat = rand(nNode);
            % This gives you a fully connected network, with weights from every node to
            % every other, including themselves. Here are only weights between the 
            % inputs and the hidden nodes. Set the weights of connections which do not 
            % exist to 0;

            wActive = zeros(nNode);
            wActive([1:nInputs], [nInputs+1:nInputs+nHidden]) = 1; % In to Hidden connections
            wActive([nInputs+1:nInputs+nHidden]  , [nInputs+nHidden+1:nInputs+nHidden+nOutputs]) = 1; % Hidden to Out connections

            % Turn inactive connections to 0;
            wMat = wMat.*wActive;
        else
            wMat = CMA_ES_EP(wMat);
        end
        

        %% Activating an Feed Forward ANN
        % We calculate the activation of each node per layer. We must know the 
        % activation levels of hidden nodes before we can calculate the activation
        % of the nodes they feed into. If we have a feed forward network we can
        % calculate each nodes activation in order, starting from the input and
        % ending at the output.

        % Put the input in as the activation of the input nodes
        nodeAct = zeros(nSample,nNode);
        nodeAct(1:nInputs) = inputVector;

        for iNode = (nInputs+1):nNode
            % Here we compute the activation of a node by applying only the 
            % relevant column of the weight matrix, and then apply the
            % activation function, in this case 'tanh', to the result.
           nodeAct(iNode) = tanh(nodeAct*wMat(:,iNode)); 
        end
        output = nodeAct(end);
%         output = 2*(rand(1)-0.5);
        action = output*force; % Scale to full force
        
        
        
        %% SIMULATE RESULT
        % Take action and return new state:
        state = cart_pole2( state, action ); 
%         if step ~= 1000
%           wMat = CMA_ES_EP(wMat)
        
        %% Visualize result (optional and slow, don't use all the time!)
        %clf
%         cpvisual(fig, 1, state(1:4), [-3 3 0 2], action );         % Pole 1
% %         cpvisual(fig, 0.5, state([1 2 5 6]), [-3 3 0 2], action );% Pole 2
%         pause(0.02);
        
   
    end

    
end