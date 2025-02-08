function out = Gaus(sigma)
    kernel_size = round(3 * sigma);  
    half_size = floor(kernel_size / 2);
    
    x = -half_size : half_size;  
    out = exp(-0.5 * (x / sigma).^2) / (sigma * sqrt(2 * pi)); 
    
    out = out / sum(out);  
end