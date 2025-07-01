function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
  [l,c] = size(FeatureMatrix);
  teta_sz = numel(Theta);
  if teta_sz - 1 ~= c
    error('dimensiuni necoresp');
  endif
  Theta(1,:) = []
  Pred = FeatureMatrix * Theta;
  Square = (Pred - Y).^2;
  Error = sum(Square) / (2 * l);
end
