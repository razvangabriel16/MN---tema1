function [Y, InitialMatrix] = parse_csv_file(file_path)
  fdes = fopen(file_path, 'r');
  if fdes == -1
      return;
  end
  line = fgetl(fdes);
  tokens = strsplit(line, ',');
  ncol = numel(tokens); %numarul de coloane al matricei
  InitialMatrix = cell(1, ncol); %initial, are doar o linie, urmand sa-i atasez dupa fiecare citire cate o linie
  nol = 1; %numarul de linii care trebuie actualizat pe parcurs
  while true
    id = fgetl(fdes);
    if id == -1 %cand nu mai avem linii
      break;
    endif
    tok = strsplit(id, ','); %fiind comma separated values, acum trebuie split-uite dupa virgula
    sz = numel(tok);
    for j = 1 : sz
      InitialMatrix{nol, j} = tok{j};
    endfor
    nol = nol + 1;
     %incrementam numarul de linii
    InitialMatrix(end + 1, :) = cell(1, ncol); %atasan la matrice o linie noua
  endwhile
  InitialMatrix(end, :) = []; %trebuie sa stergem ultima linie pentru ca nu contine nimic si a fost adaugata automat
  fclose(fdes);
  for i = 1:nol - 1
    for j = 1:ncol
      %matricea e de tipul cell si deocamdata contine doar string-uri , daca avem numere le vrem trabsformate in numere
      numValue = str2double(InitialMatrix{i, j});
      if ~isnan(numValue)
          InitialMatrix{i, j} = numValue;
      end
    end
  end
  %acelasi lucru pentru vectorul coloana Y
  for i = 1:nol - 1
      if isnumeric(InitialMatrix{i,1})
        Y(i) = InitialMatrix{i,1};
      else
        Y(i) = NaN;
      end
   end
   InitialMatrix = InitialMatrix(:, 2:end);
end
