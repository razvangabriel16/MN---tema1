function [Adj] = get_adjacency_matrix(Labyrinth)
  [lin, col] = size(Labyrinth);
  %dimensiunile matricei de adiacenta
  Adj = zeros(lin*col+2, lin*col+2);
  win = lin*col + 1;
  lose = lin*col + 2;
  Adj(win, win) = 1;
  Adj(lose, lose) =1;
  %parcurgerea nodurilor si verificarea adiacentei lor
  for i = 1:lin
      for j = 1:col
          %functie care imi transforma in baza 2, dar cu padding  maxim 4
          binary1 = dec2bin(Labyrinth(i,j), 4);
          %inversarea numarului pentru parsare mai usoara
          binary = fliplr(binary1);
          node = (i-1)*col + j;
          %cei 4 vecini ai nodului  node
          e = node - 1;
          v = node + 1;
          n = node - col;
          s = node + col;
          if i > 1 && i < lin && j > 1 && j < col
            if binary(1) == '0'
              Adj(node, e) = 1;
              Adj(e, node) = 1;
            end
            if binary(2) == '0'
              Adj(node, v) = 1;
              Adj(v,node) = 1;
            end
            if binary(3) == '0'
              Adj(node, s) = 1;
              Adj(s, node) = 1;
            end
            if binary(4) == '0'
              Adj(node, n ) = 1;
              Adj(n, node) = 1;
            end
          else
            if i == 1 && j == 1
              if binary(1) == '0'
                Adj(node, lose) = 1;
              end
              if binary(4) == '0'
                 Adj(node, win) = 1;
              end
            elseif i == 1 && j == col
              if binary(2) == '0'
                Adj(node, lose) = 1;
              end
              if binary(4) == '0'
                 Adj(node, win) = 1;
              end
            elseif i == 1 && j < col && j > 1
              if binary(4) == '0'
                 Adj(node, win) = 1;
              end
              if binary(1) == '0'
                 Adj(node, e) = 1;
                 Adj(e, node) = 1;
              end
              if binary(2) =='0'
                Adj(node, v) = 1;
                Adj(v, node) = 1;
              end
            elseif i < lin && i > 1 && j == 1
              if binary(1) == '0'
                Adj(node, lose) = 1;
              end
              if binary(3) == '0'
                Adj(node, s) = 1;
                Adj(s, node) = 1;
              end
              if binary(4) == '0'
                Adj(node, n) = 1;
                Adj(n, node) = 1;
              end
            elseif i < lin && i > 1 && j == col
              if binary(2) == '0'
                Adj(node, lose) = 1;
              end
              if binary(3) == '0'
                Adj(node, s) = 1;
                Adj(s, node) = 1;
              end
              if binary(4) == '0'
                Adj(node, n) = 1;
                Adj(n, node) = 1;
              end
            elseif i == lin && j == 1
              if binary(1) == '0'
                Adj(node, lose) = 1;
              end
              if binary(3) == '0'
                 Adj(node, win) = 1;
              end
            elseif i == lin && j > 1 && j < col
              if binary(3) == '0'
                 Adj(node, win) = 1;
              end
              if binary(1) == '0'
                 Adj(node, e) = 1;
                 Adj(e, node) = 1;
              end
              if binary(2) =='0'
                Adj(node, v) = 1;
                Adj(v, node) = 1;
              end
            elseif i==lin && j ==col
              if binary(2) == '0'
                Adj(node, lose) = 1;
              end
              if binary(3) == '0'
                 Adj(node, win) = 1;
              end
            end
          end
      end
  end
Adj = sparse(Adj)
