function [Y, InitialMatrix] = parse_data_set_file(file_path)
  %file-descriptorul asociat file-path-ului primit
  fdes = fopen(file_path, 'r');
  if fdes == -1
      return;
  end
  %linia dimensiunilor
  firstline = fgetl(fdes);
  dims= sscanf(firstline, '%d %d');
  m = dims(1);
  n = dims(2);
  InitialMatrix = cell(m,n);
  Buffer = cell(m, n+1);
  Y = zeros(m,1);
  %matricea Buffer contine si prima coloana care e echivalentul lui Y
  for i = 1 :m
    %citim linie cu linie fisierul si ii facem split, pentru ca inputul contine si numere si stringuri
    line = strsplit(fgetl(fdes), ' ');
    for j = 1: n+1
      Buffer{i,j} = line{j};
    end
  end
  fclose(fdes);
  %daca avem string-uri care contin doar cifre, incercam sa le transformam in double, pentru a ne usura parsarea
  for i = 1:m
    for j = 1:n+1
      numValue = str2double(Buffer{i, j});
      if ~isnan(numValue)
          Buffer{i, j} = numValue;
    end
  end

  %daca avem in coloana de output o valoare care nu e numerica, va fi trecuta cu tipul NaN
  for i = 1:m
      if isnumeric(Buffer{i,1})
        Y(i) = Buffer{i,1};
      else
        Y(i) = NaN;
      end
   end
   InitialMatrix = Buffer(:, 2:end);
end
