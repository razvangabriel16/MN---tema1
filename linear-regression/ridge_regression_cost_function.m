 function [Error] = ridge_regression_cost_function(Theta, Y, FeMatrix, lambda)
    Error = 0;
    Theta = Theta(2:end,:);
    Pred = FeMatrix * Theta;
    Patrate = (1/(2 * numel(Y))) * sum((Pred - Y).^2);
    Reg= lambda * sum((Theta(1:end)).^2);
    Error = Patrate + Reg;
 end
