function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
  Theta = zeros(n, 1);
  Y = Y'; %se transpune pentru a putea inmulti ulterior
  for i = 1 : iter
    Partial = (FeatureMatrix * Theta - Y); %echivalentul erorii
    Gr = (1/m) * FeatureMatrix' * Partial; %derivata functiei de cosr
    Theta = Theta - alpha * Gr; %actualilzarea lui Theta in functie de alpha
  end
  Theta = [0; Theta]; %adaugarea bias-ului
end
