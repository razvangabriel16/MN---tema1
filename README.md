//Ghiorghe Razvan Gabriel - 313CA

# Task1: MarkovIsComing

### function [Labyrinth] = parse_labyrinth(file_path)

In aceasta functie se deschide descriptorul de fisier al file_path asociat si se citesc
intitial dimensiunile matricei (pe prima linie) si dupa labirintul in sine, folosind dimensiunile
pe care le am citit. Trebuie transpus la final pentru ca in matlab citirile se fac pe coloane.

### function [Adj] = get_adjacency_matrix(Labyrinth)

Matricea de Adiacenta din acest caz functioneaza ca matricea de adiacenta din cazul unui graf
permitandu-ne sa vedem cum sunt starile noastre legate unele de celelalte. Astfel Adj(i,j)va fi
egal cu 1 daca exista o tranzitie din starea i in starea j si 0 altfel. Ca input primim matricea
de labirint, apoi transformam fiecare element din baza 10 in baza 2 folosind doar 4 "cifre binare"
(este suficient pentru ca avem doar 4 vecini maxim). Daca starile corespund WIN/LOSE se prelucreaza
corespunzator. Se parcurg starile din interiorul matricei, despre care se stie clar ca au 4 vecini si
se construieste matricea de adiacenta care e simetrica. Pentru margini si colturi s-au realizat
parcurgeri suplimentare.

### function [Lnk] = get_link_matrix(Labyrinth)

Matricea de Legaturi aduce in plus ca functionalitate fata de matricea de adiacenta probabilitatea
fiecarei stari in raport cu celelalte. Nu imi ofera doar o informatie caliltativa ci mai degraba una 
cantitativa. Procedeul de constructie este acelasi, dar difera valorile. Pentru fiecare stare se numara
cate stari vecine are, iar probabilitatea de tranzitie din starea curenta in fiecare din starile cu care
este vecina este egal cu inversul numarului de vecini. In cazul in care starea are legatura directa cu 
WIN/LOSE, vom avea 1 pe coloana WIN/LOSE si linia starii respective. 

### function [G, c] = get_Jacobi_parameters(Link)

In aceasta functie identificam matricea de iteratie si vectorul de iteratie din sistemul construit cu 
matricea Link de mai sus.
Pentru a putea realiza metoda lui Jacobi, selectam din matricea de legaturi doar liniile si coloanele 
corespunzatoare starilor "efective", fara LOSE (pentru matricea de iteratie). Pentru vectorul de iteratie
alegem coloana corespunzatoare starii de WIN.

### function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)

G si c sunt deja cunoscute, iar algoritmul functioneaza ca orice algoritm "iterativ" scris in forma matriceala.
Metoda lui Jacobi converge daca raza spectrala a matricei de iteratie (valoarea proprie maxima in modul) este < 1.
Cat timp nr. de pasi este mai mic decat max_steps si eroarea este mai mare decat toleranta, actualizam x-ul.

### function [path] = heuristic_greedy(start_position, probabilities, Adj)

Acest algoritm ne ofera o solutie optima (adica nr. minim de stari) prin care putem ajunge la starea de WIN din
fiecare nod.La fiecare pas selecteaza starea vecina nevizitata cu cea mai mare sansa de succes. Evitam ciclurile
prin vectorul de stari vizitate. Daca nu gasim nicio stare favorabila, facem backtracking.

### function [decoded_path] = decode_path(path, lines, cols)

Acest task isi propune sa gasim pentru vectorul path o matrice cu doua coloane care e corespunzatoare lui path
in care fiecare linie are coordonatele nodului din path. Astfel, codul devine mai usor de vazut din punctul de 
vedere al matricei. 

# Task2: LinearRegression

### function [Y, InitialMatrix] = parse_data_set_file(file_path)

Functia gaseste pe prima linie dimensinile matricei CELL (intrucat contine si stringuri si numere).
Ne folosim de o matrice CELL Buffer din care la final vom extrage atat Y cat si InitialMatrix.
Intrucat in Buffer, am citit linie cu linie si am pus in Buffer niste stringuri rezultate dintr-un split,
vrem ca daca string-ul nostru are doar cifre il el, elementul respectiv sa fie transformat la tipul double.

### function [FeatureMatrix] = prepare_for_regression(InitialMatrix)

Pentru a putea folosi functiile viitoare in vederea rezolvarii regresiei, nu ne putem folosi explicit
de coloanele care au doar string-uri in ele pentru ca functiile nu stiu cum sa le prelucreze.
Pentru asta, daca intr-o coloana avem yes/no, realizam codificarea 1/0. 
Analog, avem urmatoarele tranfromari:
semi-furnished -> 1, 0
unfurnished -> 0, 1 
furnished -> 0, 0
Trebuia astfel redimensionata matricea initiala, pentru ca se adauga aceste noi coloane.

### function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)

Initial, verificam ca vectorul nostru Theta sa aiba acelasi numar de linii cu Vectorul Y de rezultate
si cu nr de coloane din matricea FeatureMatrix pentru a putea realiza inmultirea corect. 
Obtinem eroarea din diferenta FeatureMatrix*Theta - Y. Ridicam apoi la patrat pe aceasta si impartim
la dublul numarului de exemple din dataset.

### function [Y, InitialMatrix] = parse_csv_file(file_path)

Functia are aceeasi logica ca parse_data_set_file, doar ca splitul se face acum dupa virgula, nu dupa ' '.

### function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)

Aici implementam metoda pasilor descendenti, in ideea in care ne dorim un Theta care sa minimizeze eroarea.
Algorimtul calculeaza initial eroarea, apoi calculeaza gradientul adica vectorul cu derivatele partiale ale functiei
de cost in raport cu fiecare theta_i. Vectorul Theta apoi este actualizat in directia opusa gradientului, inmultit cu
o rata de invatare.

### function [Theta] = normal_equation(FeaturesMatrix, Y, tol, iter)

Pentru a evita inversarea directa a matricei intrucat nu este eficient, avem acelasi scop ca mai sus dar vrem ca
algoritmul sa convearga dupa n pasi (n este nr de necunoscute). Construim solutia Theta pe directii de cautare FeatureMatrix conjugate.
Prin alpha determinam cat de mult sa ne deplasam pe directia respectiva si actualizam atat vectorul de solutii cat si reziduul.
Noul reziduu ajuta la calculul directiei urmatoare prin Beta, care asigura proprietatea de conjugare. La fel ca mai sus, are aceeasi
structura ca orice metoda iterativa (nr de pasi, toleranta etc.).

### function [Error] = lasso_regression_cost_function(Theta, Y, FeMatrix, lambda)

Functiile de rgularizare au rolul de a controla complexitatea modelului si de a reduce overfitting-ul pt regresie. Adica pentru un
set de date nou, incurajam modelul sa pastreze doar coeficientii esentiali. Aceasta regularizare poate face chiar unii coeficienti 0.

### function [Error] = ridge_regression_cost_function(Theta, Y, FeMatrix, lambda)

Are aceeasi functionalitate ca cea de mai sus, dar aici coeficientii in cauza nu pot ajunge nuli, ci doar foarte aproape de zero.
Ridge pastreaza toate caracteristicile dar micsoreaza influenta unora dintre ele.

# Task3: MNIST-101

### function [X, y] = load_dataset(path)

Incarc dataset-ul cu ajutorul functiei load care primeste cale relativa la un fisier de tip .mat. Aici avem intreg setul de date care e format
din datele de test si datele de antrenament.

### function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)

Aflu dimensiunea matricei X si a coloanei y. Imi creez un vector de frecventa in care memorez indexurile liniilor pe care le selectez ca fiind de antrenament.
Realizez o verificare ca numarul de linii rezultat din inmultirea procentajului (subunitar) cu numarul total de linii este intreg. Cat timp nu am selectat 
suficiente linii pt antrenament, cu ajutorul functiei randi(l1) generez un intreg intre 1 si l1. acesta imi poate returna acelasi rezultat la mai multe apeluri deci acesta este motivul pentru care folosesc un vector de frecveta. Daca nu a mai aparut la niciun apel(in vectorul de frecventa) adaug linia respectiva la X_train si rezultatul corespunzator liniei la y_train. Ulterior, indecsii care au in vectorul de frecventa valoarea 0 sunt pusi la setul de test.

### function [matrix] = initialize_weights(L_prev, L_next)

Initializez matricea matrix cu niste valori aleatoare din intervalul `(-alpha, alpha)`, unde alpha este dat in cerinta. Fac aceasta generare de valori in intervalul ales.   A = -epsn + (2 * epsn) * rand(L_next, L_prev + 1) Aceasta formula genereaza cu ajutorul functiei rand o matrice de dimensiunile
L_next, L_prev + 1 cu valori intre 0 si 1. Cu ajutorul acelor inmultiri si ulterior cu acea scadere obtinem exact intervalul dorit.

### function [J, grad] = cost_function(params, X, y, lambda, input_layer_size, hidden_layer_size, output_layer_size)

In aceasta functie am efectuat atat forward propagation astfel: Pentru input, punem un bias la X, inmultesc acest rezultat cu Theta1, aplic functia de
activare si repet acest procedeu si pentru zona dintre hidden_layer si output_layer (asta a fost forward propagation). Costul este calculat folosind formula logistică la care adaugam termenul de regularizare care penalizează valorile mari ale greutatilor. Apoi aplica algoritmul backpropagation pentru a determina cat de mult contribuie fiecare greutate la eroare. Regularizeaza gradientul si returnează atat costul, cat și gradientul, în forma ceruta de algoritmii de optimizare.

### function [classes] = predict_classes(X, weights, input_layer_size, hidden_layer_size, output_layer_size)

Vectorul weights contine toate valorile matricilor Theta1 si Theta2 puse cap la cap. Le separam si le remodelm în matrici: 
Theta1: dimensiune `hidden_layer_size × (input_layer_size + 1)` si Theta2: dimensiune `output_layer_size × (hidden_layer_size + 1)`. Classes este intializat cu 0 initial. Facem apoi forward propagation pentru fiecare exemplu (fiecare linie).  Aplic apoi procedeul de mai sus (cu layer-ele) si dupa ultima activare aflu indexul cu cea mai mare porbabilitate care corespunde cifrei care teoretic seamana cel mai mult cu pixelii. Pun apoi in vectorul classes rezultatul.