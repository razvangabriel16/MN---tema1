 function [Error] = lasso_regression_cost_function(Theta, Y, FeMatrix, lambda)
    %regulariazarea L1 (Lasso) functioneaza penalziand coeficientii mari intrucat adauga un cost mare
    %previne overfitting-ul
    Error = 0;
    Theta = Theta(2:end,:); %se elimina biasul din regularizarea L1
    Pred = FeMatrix * Theta;
    Patrate = (1/numel(Y)) * sum((Pred - Y).^2);
    Reg = lambda * sum(abs(Theta(1:end)));
    Error = Patrate + Reg;
 end
