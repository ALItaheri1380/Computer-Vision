function noisy_img = Add_Noise(img, p, type)
    noisy_img = img;
    
    if strcmp(type, 'pepper')
        noise_mask = rand(size(img));
        noisy_img(noise_mask < p / 2) = 0;  
        noisy_img(noise_mask > 1 - (p / 2)) = 1;  
        
    elseif strcmp(type, 'gaussian')
        noise = p * randn(size(img));
        noisy_img = noisy_img + noise;
        noisy_img = max(0, min(1, noisy_img));  
    end
end
