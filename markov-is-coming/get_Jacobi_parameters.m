function [G, c] = get_Jacobi_parameters(Link)
  [m,n] = size(Link);
  newsz = m - 2;
  %inlaturarea ultimelor 2 linii suplimentare din matricea de probabilitati
  G = Link(1:newsz, 1:newsz);
  c = Link(:, newsz + 1);
  c = c(1:end-2);
  G = sparse(G)
  c = sparse(c)
endfunction
