function [matrix] = initialize_weights(L_prev, L_next)
  A = zeros(L_next, L_prev + 1);
  epsn = sqrt(6) / sqrt(L_prev + L_next);
  %a = min(L_prev, L_next);
  %b = max(L_prev, L_next);
  %for i = 1:L_next
  %  for j = 1:L_prev+1
  %    r = -epsn + (2 * epsn) * rand();
  %    A(i,j) = r;
  %  endfor
  %endfor
  A = -epsn + (2 * epsn) * rand(L_next, L_prev + 1);
  matrix = A;
end
