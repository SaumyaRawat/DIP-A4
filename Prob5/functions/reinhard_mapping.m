% Tone Mapping Operator, by Reinhard 02 paper. %
function output = reinhard_mapping(img, a)
    output = zeros(size(img));

    if( ~exist('a') )
        a = 0.18;
    end

    delta = 1e-6;
    white = 1.5;
    phi = 4;
    epsilon = 1e-4;
    Lw = rgb2gray(img);
    LwMean = exp(mean(mean(log(delta + Lw))));
    Lm = (a / LwMean) * Lw;
    figure;imshow(Lm);
    Ld = (Lm .* (1 + Lm / (white * white))) ./ (1 + Lm);
    for channel = 1:3
    	Cw = img(:,:,channel) ./ Lw;
        output(:,:,channel) = Cw .* Ld;
    end

end
