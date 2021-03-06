function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
X = [ones(m, 1) X]; 
_y = zeros(1,num_labels);
% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%



for i=1:m
    _y(y(i)) = 1;
    %for k=1:num_labels
        J += sum(log(sigmoid([1 sigmoid(X(i,:)*Theta1')]*Theta2'))*(-_y)' - log(1-sigmoid([1 sigmoid(X(i,:)*Theta1')]*Theta2'))*(1-_y)');
    %end
    _y = zeros(1,num_labels);
end
J = sum(J)/m + (sum(sum(Theta1(:, 2:end).*Theta1(:, 2:end))) + sum(sum(Theta2(:, 2:end).*Theta2(:, 2:end))))*lambda/(2*m);   %不包括Theta0
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
_y = zeros(num_labels,1);
big_delta_1 = zeros(hidden_layer_size, input_layer_size);
big_delat_2 = zeros(num_labels, hidden_layer_size);
for t=1:m
    %step 1
    a_1 = [X(t,:)'];%401x1
    z_2 = Theta1*a_1;%25x1
    a_2 = sigmoid(z_2);%25x1
    a_2 = [1;a_2];%26x1
    z_3 = Theta2*a_2;%10x1
    a_3 = sigmoid(z_3);%10x1
    
    %step 2
    _y(y(t)) = 1;
    delta_3 = a_3.-_y;
    delta_2 = Theta2'*delta_3.*[1;sigmoidGradient(z_2)];

    %step 3
    Theta1_grad = Theta1_grad.+ delta_2(2:end)*a_1';
    Theta2_grad = Theta2_grad.+ delta_3*a_2';
    _y = zeros(num_labels,1);
end
%grad = [Theta1_grad(:);Theta2_grad(:)];
%checkNNGradients(lambda);
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
Theta1_grad = Theta1_grad/m.+lambda/m*[zeros(hidden_layer_size,1), Theta1(:, 2:end)];
Theta2_grad = Theta2_grad/m.+lambda/m*[zeros(num_labels,1), Theta2(:, 2:end)];
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
