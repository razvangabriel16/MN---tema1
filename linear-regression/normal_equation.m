function [Theta] = normal_equation(FeaturesMatrix, Y, tol, iter)
  [l,c] = size(FeaturesMatrix);
  if l~=c
    return;
  end
  Theta = zeros(c,1);
  %verificare matrice simetrica si pozitiv definita

  %if ~isequal(FeaturesMatrix, FeaturesMatrix')
  %  return;
  %end
  %eigenv = eig(FeaturesMatrix); %sau cu cholesky. daca dadea eroare nu era poz def
  %if ~all(eigenv >= 0)
  %  return;
  %end

  r = Y; %vectorul reziduu intial
  p = r; %prima directie de cautare
  k = 0; %nr de pasi intial
  %solutie cu gradient conjugat care construieste solutia pe baza unor directii conjugate intre ele
  while k <= iter
     alpha = (r' * r)/(p' * FeaturesMatrix * p); %cat de mult ma deplassez pe directia curenta
     Theta = Theta + alpha * p;
     rprev = r;
     r = r - (alpha * FeaturesMatrix * p); %actualizam reziduul
     beta = (r' * r) / (rprev' * rprev); %coeficient pt actualizarea directiei de cautare
     p = r + beta*p;
     k = k + 1;
     if norm(r,2) < tol
       break;
     endif
  end
  Theta = [0; Theta];
end
