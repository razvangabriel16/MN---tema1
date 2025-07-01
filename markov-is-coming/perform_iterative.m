function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)
    G = full(G);
    c = full(c);
    n = size(G,1);
    Dia = diag(diag(G));
    Rest = G - Dia;
    tol = abs(tol);
    diag_G = diag(G);
    %daca avem pozitii cu 0 pe diagonala principala, schimbam si punem echivalentul
    %unui "versor" pe directia respectiva si deci punem 1 sa nu avem probleme la inversare
    diag_G(diag_G == 0) = 1;
    inv_Dia = diag(1 ./ diag_G);
    J_step = inv_Dia * Rest;
    S_step = inv_Dia * c;

    %pentru metoda Jacobi daca stim ca matricea e diagonal dominanta, atunci avem convergenta sigura
    %daca nu e diagonal dominanta, avem incertitudine

    %is_domin = true;
    %for i = 1:n
    %    sumdiag = sum(abs(G(i,:))) - abs(G(i,i));
    %    if abs(G(i,i)) < sumdiag
    %        is_domin= false;
    %    end
    %end
    %if ~is_domin
    %    error(nu avem diagonal dominanta)
    %end

    x = x0;
    err = abs(tol) + 1;
    steps = 0;
    while steps < max_steps && err >= tol
        x_new = J_step * x + S_step;
        err = norm(x_new - x, 2);
        x = x_new;
        steps = steps + 1;
    end
    x
    err
    steps
end
