function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

% You need to set these values correctly
X_norm = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));

% ====================== YOUR CODE HERE ======================
% Instructions: First, for each feature dimension, compute the mean
%               of the feature and subtract it from the dataset,
%               storing the mean value in mu. Next, compute the 
%               standard deviation of each feature and divide
%               each feature by it's standard deviation, storing
%               the standard deviation in sigma. 
%
%               Note that X is a matrix where each column is a 
%               feature and each row is an example. You need 
%               to perform the normalization separately for 
%               each feature. 
%
% Hint: You might find the 'mean' and 'std' functions useful.
%       


m = size(X,1);
mu = mean(X);
mu_m = mu;
sigma = std(X);
sigma_m = sigma;
for i=1:m-1
    mu_m = [mu_m;mu];
    sigma_m = [sigma_m;sigma];
end
%X_norm = [(X(:,1).-mu(1))/sigma(1) (X(:,2).-mu(2))/sigma(2)];
X_norm = (X.-mu_m)./sigma_m;
%X_norm = [(X(:,1).-mu(1)*ones(m,1))/((max(X)-min(X))(1)), (X(:,2).-mu(2)*ones(m,1))/((max(X)-min(X))(2))];






% ============================================================

end
