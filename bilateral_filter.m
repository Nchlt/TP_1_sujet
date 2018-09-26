    %% Generate observed image
    clear all;
    close all;
    I=double(imread('flowers.bmp'))/255; %% Image loading
    I=mean(I,3);
    sizeI=size(I);
    %% Apply noise to the original image
    noise_coef = 0.1; % Coef de bruitage initial
    u=I+noise_coef*randn(sizeI);
    %figure; imshow(u);title('Noisy observed image');

    % Denoise
    w=3;
    sigma_s=1;
    sigma_i=2;
    size_I_noisy=size(u);

    %% Bilateral filtering.
    % Pre-compute Gaussian distance weights.
    % Step1.
    spatial_weights=zeros(2*w+1,2*w+1);
    for x_1=1:2*w+1
        for x_2=1:2*w+1
           % Notre S :
           spatial_weights(x_1,x_2) = exp( - ( (x_1-w-1)^2 + (x_2-w-1)^2 ) / 2*sigma_s^2 );
        end;
    end;

% Step2.
% Calcul de u tilde et T
N = size_I_noisy(1);
M = size_I_noisy(2);
% matrice qui contiendra l image finale :
denoisedI = u;

for p_2 = w+1:M-w
   for p_1 = w+1:N-w
        % Calcul de u tilde
        u_t = u(p_1-w:w+p_1, p_2-w:w+p_2);
        t = exp( - (u_t - u(p_1, p_2) )^2  / 2 * sigma_i^2 );
        % Constante de noramlisation
        C = sum( sum( spatial_weights .* t ) );
        % On remplit la matrice résultat
        denoisedI(p_1, p_2) = (sum( sum( u_t .* spatial_weights .* t ))) ./ C;
    end;
end;
%figure;imshow(denoisedI);title('Denoised image');

% Sauvegarde des résultats
out_file_name = ["noise" num2str(noise_coef) "_w" num2str(w) "_s" num2str(sigma_s) "_i" num2str(sigma_i) "_out.png" ]
imwrite(denoisedI, ["results/" out_file_name]);
imwrite(u, ["results/" "noise" num2str(noise_coef) "_in.png"]);
