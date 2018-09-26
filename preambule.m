% Q2.
% Création d'une matrice de zeros de taille 512 x 512 qui servira d' image
m = zeros(512,512);
% On allume les pixels du carré {200,...,250}*{200,...,250}
m(200:250,200:250) = 1;
% Affichage
imshow(m);

% Q5.
// m = ones(512);
// m = imnoise(m, "Gaussian",  0.5, 5);
// m
// imshow(m);

m = ones(2);
m = imnoise(m, "Gaussian", 0.5, 0.2);
m
