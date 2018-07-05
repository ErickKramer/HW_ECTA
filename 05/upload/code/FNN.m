function [output, wMat] = FNN(scaledInput)
%         nSample = 1; nInputs = 6;
% 
%         inputVector = rand(nSample, nInputs); 
%         disp('Input Vector Size: '); disp(size(inputVector))

        inputVector = scaledInput'; 


        %% Weight Matrix 
        % [nInputs X nOutputs]
        
        nSample =1;nInputs = length(inputVector); nHidden = 3; nOutputs = 1; 
        nNode = nInputs+nHidden+nOutputs;
        wMat = rand(nNode);
%         disp('Weight Matrix Size: '); disp(size(wMat))

        % This gives you a fully connected network, with weights from every node to
        % every other, including themselves. Here are only weights between the 
        % inputs and the hidden nodes. Set the weights of connections which do not 
        % exist to 0;

        wActive = zeros(nNode);
        wActive([1:nInputs], [nInputs+1:nInputs+nHidden]) = 1; % In to Hidden connections
        wActive([nInputs+1:nInputs+nHidden]  , [nInputs+nHidden+1:nInputs+nHidden+nOutputs]) = 1; % Hidden to Out connections

        % Turn inactive connections to 0;
        wMat = wMat.*wActive;
        
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
end
