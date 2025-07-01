function [FeatureMatrix] = prepare(InitialMatrix)
  [m n] = size(InitialMatrix);
  FeatureMatrix = zeros(m, n+1);
  cnt = 0;
  for i = 1:n
    ok=0;
    for j = 1:m
      %pentru yes/no  folosim codificarea 1/0
      if strcmp(InitialMatrix{j,i}, 'yes')
        FeatureMatrix(j,i+cnt) = 1;
      %in aceste cazuri ok semnaleaza nevoia unei coloane suplimentare
      elseif strcmp(InitialMatrix{j,i}, 'no')
        FeatureMatrix(j,i+cnt) = 0;
      elseif strcmp(InitialMatrix{j,i}, 'semi-furnished')
        FeatureMatrix(j,i+cnt) = 1;
        FeatureMatrix(j, i+1+cnt) = 0;
        ok = 1;
      elseif strcmp(InitialMatrix{j,i}, 'furnished')
        FeatureMatrix(j,i+cnt) = 0;
        FeatureMatrix(j,i+1+cnt) = 0;
        ok = 1;
      elseif strcmp(InitialMatrix{j,i}, 'unfurnished')
        FeatureMatrix(j,i+cnt) = 0;
        FeatureMatrix(j,i+1+cnt) = 1;
        ok = 1;
      else
        %daca nu e string, valoare ramane neschimbata
        FeatureMatrix(j,i+cnt) = InitialMatrix{j,i};
      end
    endfor
    %daca am adaugagt coloana suplimentara, crestem contorul pt coloane
    if ok == 1
      cnt = cnt + 1;
    endif
  endfor
end

