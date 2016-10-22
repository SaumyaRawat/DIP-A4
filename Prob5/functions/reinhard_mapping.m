% Tone Mapping Operator, by Reinhard 02 paper. %
function output = reinhard_mapping(img, a)
    output = zeros(size(img));

    if( ~exist('a') )
        a = 0.18;
    end

    delta = 1e-6;
    Lw = img;%0.27*img(:,:,1)+0.67*img(:,:,2)+0.06*img(:,:,3);
    LwMean = exp(mean(mean(log(delta + Lw))));

    Lm(:,:,1) = (a * Lw(:,:,1)) / LwMean(:,:,1);
    Lm(:,:,2) = (a * Lw(:,:,2)) / LwMean(:,:,2);
    Lm(:,:,3) = (a * Lw(:,:,3)) / LwMean(:,:,3);
    output = Lm;
%    figure;imshow(Lm);

%    white = 1.5;
%    Ld = (Lm .* (1 + Lm / (white * white))) ./ (1 + Lm);
%    for channel = 1:3
%    	Cw = img(:,:,channel) ./ Lw;
%        output(:,:,channel) = Cw .* Ld;
%    end

end
