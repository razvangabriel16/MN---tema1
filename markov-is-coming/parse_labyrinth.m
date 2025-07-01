function [Labyrinth] = parse_labyrinth(file_path)
  %file-descriptorul asociat file_path
  fdes = fopen(file_path, 'r');
  %daca acesta intampina o eroare, marcam corespunzator
  if fdes == -1
      error('problem for opening %s', file_path);
  end
  %linia dimensiunilor
  firstline = fgetl(fdes);
  dims = sscanf(firstline, '%d %d');
  m = dims(1);
  n = dims(2);
  %citirea labirintului propriu-zis
  data = fscanf(fdes, '%d', [n, m]);
  fclose(fdes);
  Labyrinth = data'
end
