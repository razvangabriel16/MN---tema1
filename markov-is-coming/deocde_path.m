function [decoded_path] = decode_path(path, lines, cols)
  size_p = numel(path) - 1;
  decoded_path = zeros(size_p,2); %avem doua coloane pentru linia si coloana celulei cu codificarea data
  for i = 1:size_p
    node = path(i);
    %calculam indexul liniei
    line_var = floor((node - 1) / cols) + 1
    %calculam indexul coloanei
    col_var = mod(node,cols);
    if col_var == 0
      col_var = cols;
    end
    decoded_path(i, 1) = line_var;
    decoded_path(i, 2) = col_var;
  end
end
