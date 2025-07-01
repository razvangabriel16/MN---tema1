function [path] = heuristic_greedy(start_position, probabilities, Adj)
  Adj = full(Adj);
  %initial vectorul de cautare este gol
  path = [];
  path(end + 1) = start_position; %punem pe prima pozitie valoarea primita de functie
  size_v = numel(probabilities); %dimensiunea vectorului de probabilitati
  visited = zeros(size_v,1); %vectorul de vizitare
  visited(start_position) = 1;
  while ~isempty(path)
    position = path(end);
    if probabilities(position) == 1 %calea in care reusim sa iesim
      return;
    end
    index = -1;
    maxi = 0;
    %gasirea probabilitatii maxime
    for i = 1:size_v
      if Adj(position,i) == 1 && visited(i) == 0
        if probabilities(i) > maxi
          maxi = probabilities(i);
          index = i;
        end
      end
    end
    %verificare in functie de indexul pe care l-am gaasit
    if index == -1
      visited(path(end)) = 0;
      path(end) = [];
    else
      visited(index) = 1;
      path(end + 1) = index;
    end
  end
  path = path';
  path
end
