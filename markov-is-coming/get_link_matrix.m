function [Lnk] = get_link_matrix(Labyrinth)
  [lin, col] = size(Labyrinth);
  %dimensiunile matricei Lnk
  Lnk = zeros(lin*col+2, lin*col+2);
  win = lin*col + 1;
  lose = lin*col + 2;
  Lnk(win, win) = 1;
  Lnk(lose, lose) =1;
  %parcurgerea nodurilor si verificarea adiacentei lor
  for i = 1:lin
      for j = 1:col
          %transformarea in baza 2 dar cu dimensiunea (inclusiv padding cu 0) maxim 4
          binary1 = dec2bin(Labyrinth(i,j), 4);
          %inversarea numarului pentru o parsare mai usoara
          binary = fliplr(binary1);
          node = (i-1)*col + j;
          %vecinii nodului
          e = node - 1;
          v = node + 1;
          n = node - col;
          s = node + col;
          %contorul care are numarul de vecini
          suma = 0;
          if i > 1 && i < lin && j > 1 && j < col
            if binary(1) == '0'
              Lnk(node, e) = 1;
              suma = suma + 1;
            end
            if binary(2) == '0'
              Lnk(node, v) = 1;
              suma = suma + 1;
            end
            if binary(3) == '0'
              Lnk(node, s) = 1;
              suma = suma + 1;
            end
            if binary(4) == '0'
              Lnk(node, n ) = 1;
              suma = suma + 1;
            end
          else
            if i == 1 && j == 1
              if binary(1) == '0'
                Lnk(node, lose) = 1;
                suma = suma + 1;
              end
              if binary(4) == '0'
                 Lnk(node, win) = 1;
                 suma = suma + 1;
              end
              if  binary(2) == '0'
                Lnk(node, v) = 1;
                suma = suma + 1;
              end
              if binary(3) == '0'
                Lnk(node, s) = 1;
                suma = suma + 1;
              end
            elseif i == 1 && j == col
              if binary(2) == '0'
                Lnk(node, lose) = 1;
                suma = suma + 1;
              end
              if binary(4) == '0'
                 Lnk(node, win) = 1;
                 suma = suma + 1;
              end
              if binary(1) == '0'
                Lnk(node, e) = 1;
                suma = suma + 1;
              end
              if binary(3) == '0'
                Lnk(node, s) = 1;
                suma = suma + 1;
              end
            elseif i == 1 && j < col && j > 1
              if binary(4) == '0'
                 Lnk(node, win) = 1;
                 suma = suma + 1;
              end
              if binary(1) == '0'
                 Lnk(node, e) = 1;
                 suma = suma + 1;
              end
              if binary(2) =='0'
                Lnk(node, v) = 1;
                suma = suma + 1;
              end
              if binary(3) == '0'
                Lnk(node, s) = 1;
                suma = suma + 1;
              end
            elseif i < lin && i > 1 && j == 1
              if binary(1) == '0'
                Lnk(node, lose) = 1;
                suma = suma + 1;
              end
              if binary(3) == '0'
                Lnk(node, s) = 1;
                suma = suma + 1;
              end
              if binary(4) == '0'
                Lnk(node, n) = 1;
                suma = suma + 1;
              end
              if binary(2) == '0'
                Lnk(node, v) = 1;
                suma = suma + 1;
              end
            elseif i < lin && i > 1 && j == col
              if binary(2) == '0'
                Lnk(node, lose) = 1;
                suma = suma + 1;
              end
              if binary(3) == '0'
                Lnk(node, s) = 1;
                suma = suma + 1;
              end
              if binary(4) == '0'
                Lnk(node, n) = 1;
                suma = suma + 1;
              end
              if binary(1) == '0'
                Lnk(node, e) = 1;
                suma = suma + 1;
              end
            elseif i == lin && j == 1
              if binary(1) == '0'
                Lnk(node, lose) = 1;
                suma = suma + 1;
              end
              if binary(3) == '0'
                 Lnk(node, win) = 1;
                 suma = suma + 1;
              end
              if binary(2) == '0'
                Lnk(node, v) = 1;
                suma = suma + 1;
              end
              if binary(4) == '0'
                Lnk(node, n) = 1;
                suma = suma + 1;
              end
            elseif i == lin && j > 1 && j < col
              if binary(3) == '0'
                 Lnk(node, win) = 1;
                 suma = suma + 1;
              end
              if binary(1) == '0'
                 Lnk(node, e) = 1;
                 suma = suma + 1;
              end
              if binary(2) =='0'
                Lnk(node, v) = 1;
                suma = suma + 1;
              end
              if binary(4) == '0'
                 Lnk(node, n) = 1;
                 suma = suma + 1;
              end
            elseif i==lin && j ==col
              if binary(2) == '0'
                Lnk(node, lose) = 1;
                suma = suma + 1;
              end
              if binary(3) == '0'
                 Lnk(node, win) = 1;
                 suma = suma + 1;
              end
              if binary(1) =='0'
                Lnk(node, e) = 1;
                suma = suma + 1;
              end
              if binary(4) =='0'
                Lnk(node, n) = 1;
                suma = suma + 1;
              end
            end
          end
          %modificarea valorilor in matricea de  Lnk cu  probabailitatile aferente
          if suma > 0
            if Lnk(node, win) == 1
              Lnk(node, win) = 1/suma;
            end
            if Lnk(node, lose) == 1
              Lnk(node, lose) = 1/suma;
            end
            if n > 0   && n <= lin*col && Lnk(node, n) == 1
              Lnk(node, n) = 1/suma;
            end
            if s > 0 && s <=lin*col && Lnk(node, s) == 1
              Lnk(node, s) = 1/suma;
            end
            if e > 0 && e <= lin*col && Lnk(node, e) == 1
              Lnk(node, e) = 1/suma;
            end
            if v > 0 && v <= lin*col && Lnk(node, v) == 1
              Lnk(node, v) = 1/suma;
            end
          end
      end
  end
Lnk = sparse(Lnk)
endfunction
